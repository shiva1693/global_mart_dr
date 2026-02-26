output "health_lambda_arn" {
  value = aws_lambda_function.health.arn
}
output "products_lambda_arn" {
  value = aws_lambda_function.products.arn
}
output "orders_lambda_arn" {
  value = aws_lambda_function.orders.arn
}

output "health_lambda_invoke_arn" {
  value = aws_lambda_function.health.invoke_arn
}
output "products_lambda_invoke_arn" {
  value = aws_lambda_function.products.invoke_arn
}
output "orders_lambda_invoke_arn" {
  value = aws_lambda_function.orders.invoke_arn
}

output "products_lambda_source_code_size" { value = aws_lambda_function.products.source_code_size }
output "orders_lambda_source_code_size" { value = aws_lambda_function.orders.source_code_size }
output "health_lambda_source_code_size" { value = aws_lambda_function.health.source_code_size }

output "products_lambda_name" { value = aws_lambda_function.products.function_name }
output "orders_lambda_name" { value = aws_lambda_function.orders.function_name }
output "health_lambda_name" {value = aws_lambda_function.health.function_name }