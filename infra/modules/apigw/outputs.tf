#https://<api-id>.execute-api.<region>.amazonaws.com/<stage>
output "invoke_url" {
    value = "https://${aws_api_gateway_rest_api.api.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.dev.stage_name}"
}

output "rest_api_id" {
  value = aws_api_gateway_rest_api.api.id
}

output "stage_name" {
  value = aws_api_gateway_stage.dev.stage_name
}