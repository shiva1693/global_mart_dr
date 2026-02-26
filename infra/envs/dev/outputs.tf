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

output "primary_stage_name_debug" {
  value = module.api_gateway_primary.stage_name
}

output "secondary_stage_name_debug" {
  value = module.apigw_secondary.stage_name
}