
# ACM Certificates & DNS validation
resource "aws_acm_certificate" "primary" {
  domain_name = var.domain_name
  validation_method = "DNS"
  tags = var.tags
}

resource "aws_acm_certificate" "secondary" {
  provider = aws.secondary
  domain_name = var.domain_name
  validation_method = "DNS"
  tags = var.tags
}

# Create Route53 record for ACM validation 
resource "aws_route53_record" "primary_validation" {
  zone_id = var.zone_id
  name = tolist(aws_acm_certificate.primary.domain_validation_options)[0].resource_record_name
  type = tolist(aws_acm_certificate.primary.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.primary.domain_validation_options)[0].resource_record_value]
  ttl = 60

  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "primary" {
  certificate_arn = aws_acm_certificate.primary.arn
  validation_record_fqdns = [aws_route53_record.primary_validation.fqdn]
}

resource "aws_route53_record" "secondary_validation" {
  zone_id = var.zone_id
  name = tolist(aws_acm_certificate.secondary.domain_validation_options)[0].resource_record_name
  type = tolist(aws_acm_certificate.secondary.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.secondary.domain_validation_options)[0].resource_record_value]
  ttl = 60

  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "secondary" {
  provider = aws.secondary
  certificate_arn = aws_acm_certificate.secondary.arn
  validation_record_fqdns = [aws_route53_record.secondary_validation.fqdn]

}
  
#Creating API Gateway Custom Domains(REGIONAL)
resource "aws_api_gateway_domain_name" "primary" {
  domain_name   = var.domain_name
  regional_certificate_arn = aws_acm_certificate_validation.primary.certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
    tags = var.tags
}

resource "aws_api_gateway_domain_name" "secondary" {
  provider = aws.secondary
  domain_name   = var.domain_name
  regional_certificate_arn = aws_acm_certificate_validation.secondary.certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
    tags = var.tags
}

# Mapping custom domain to API stage (so now /health can work without /dev prefix)
resource "aws_api_gateway_base_path_mapping" "primary" {
  api_id = var.primary_rest_api_id
  stage_name = var.primary_stage_name
  domain_name = aws_api_gateway_domain_name.primary.domain_name
  base_path   = ""
}

resource "aws_api_gateway_base_path_mapping" "secondary" {
  provider = aws.secondary
  api_id = var.secondary_rest_api_id
  stage_name  = var.secondary_stage_name
  domain_name = aws_api_gateway_domain_name.secondary.domain_name
  base_path   = ""
}

# Route53 Health Check for API Gateway Custom Domain (Do this to ensure Route53 failover diverts traffce to secondary regions when 
# primary region is unhealthy)
resource "aws_route53_health_check" "primary" {
  fqdn = "${var.primary_rest_api_id}.execute-api.${var.primary_region}.amazonaws.com"
  port = 443
  type = "HTTPS_STR_MATCH"
  resource_path = "/${var.primary_stage_name}/health"
  search_string     = "\"status\": \"ok\""
  failure_threshold = 5
  request_interval  = 10
}

resource "aws_route53_health_check" "secondary" {
  fqdn          = "${var.secondary_rest_api_id}.execute-api.${var.secondary_region}.amazonaws.com"
  port = 443
  type = "HTTPS_STR_MATCH"
  resource_path = "/${var.secondary_stage_name}/health"
  search_string     = "\"status\": \"ok\""
  failure_threshold = 5
  request_interval  = 10
}

# Failover DNS (ALIAS A records) 
resource "aws_route53_record" "api_primary" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"

  set_identifier = "primary"

  failover_routing_policy {
    type = "PRIMARY"
  }

  health_check_id = aws_route53_health_check.primary.id

  alias {
    name  = aws_api_gateway_domain_name.primary.regional_domain_name
    zone_id = aws_api_gateway_domain_name.primary.regional_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "api_secondary" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"

  set_identifier = "secondary"

  failover_routing_policy {
    type = "SECONDARY"
  }

  health_check_id = aws_route53_health_check.secondary.id

  alias {
    name  = aws_api_gateway_domain_name.secondary.regional_domain_name
    zone_id = aws_api_gateway_domain_name.secondary.regional_zone_id
    evaluate_target_health = true
  }
}