output "primary_regional_domain_name" {
  value = aws_api_gateway_domain_name.primary.regional_domain_name
}

output "secondary_regional_domain_name" {
  value = aws_api_gateway_domain_name.secondary.regional_domain_name
}