output "api_dr_zone_name_servers" {
  value = aws_route53_zone.api_dr.name_servers
}

output "api_dr_zone_id" {
  value = aws_route53_zone.api_dr.id
}

output "api_dr_zone_arn" {
  value = aws_route53_zone.api_dr.arn
}