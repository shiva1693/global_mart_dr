output "apigw_primary_invoke_url" {
  value = module.api_gateway_primary.invoke_url
}

output "apigw_secondary_invoke_url" {
  value = module.apigw_secondary.invoke_url
}

output "api_dr_zone_name_servers" {
  value = module.dns_api.api_dr_zone_name_servers
}

output "api_dr_zone_id" {
  value = module.dns_api.api_dr_zone_id
}

output "api_dr_zone_arn" {
  value = module.dns_api.api_dr_zone_arn
}