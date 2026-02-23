data "aws_caller_identity" "current" {}

# Packaging the Products(Node) lambda function into a zip file and creating the lambda function
data "archive_file" "products_zip" {
  type = "zip"
  source_dir = "${path.root}/../../../${var.products_src_dir}"
  output_path = "${path.module}/build/products.zip"
}

resource "aws_lambda_function" "products" {
  description = "Lambda function handles product related operations"
  function_name = "${var.name_prefix}-products-${var.region}"
  role    = "${var.lambda_role_arn}"
  handler = "index.handler"
  runtime = "nodejs20.x"
  package_type = "Zip"

  filename      = data.archive_file.products_zip.output_path
  source_code_hash   = data.archive_file.products_zip.output_base64sha256

  timeout = 20
  memory_size = 256 
  
  environment {
    variables = {
      TABLE_NAME = var.table_name
      ENVIRONMENT = var.environment
      APP_REGION = var.region
      SERVICE = "products"
    }
  }
  tags = var.tags
}

# Packaging the Orders(Python) lambda function into a zip file and creating the lambda function

data "archive_file" "orders_zip" {
  type = "zip"
  source_dir = "${path.root}/../../../${var.orders_src_dir}"
  output_path = "${path.module}/build/orders.zip"
}

resource "aws_lambda_function" "orders" {
  description = "Lambda function handles orders related operations"
  function_name = "${var.name_prefix}-orders-${var.region}"
  role      = var.lambda_role_arn
  handler   = "lambda_function.lambda_handler"
  runtime = "python3.12"

  filename      = data.archive_file.orders_zip.output_path
  source_code_hash   = data.archive_file.orders_zip.output_base64sha256

  timeout = 20
  memory_size = 256 
  
  environment {
    variables = {
      TABLE_NAME = var.table_name
      ENVIRONMENT = var.environment
      APP_REGION = var.region
      SERVICE = "orders"
    }
  }
  tags = var.tags
}

# Packaging the Health(Python) lambda function into a zip file and creating the lambda function
data "archive_file" "health_zip" {
  type = "zip"
  source_dir = "${path.root}/../../../${var.health_src_dir}"
  output_path = "${path.module}/build/health.zip"
}

resource "aws_lambda_function" "health" {
  description = "Lambda function handles health related operations"
  function_name = "${var.name_prefix}-health-${var.region}"
  role      = var.lambda_role_arn
  handler   = "lambda_function.lambda_handler"
  runtime = "python3.12"

  filename      = data.archive_file.health_zip.output_path
  source_code_hash   = data.archive_file.health_zip.output_base64sha256

  timeout = 20
  memory_size = 256 
  
  environment {
    variables = {
      TABLE_NAME = var.table_name
      ENVIRONMENT = var.environment
      APP_REGION = var.region
      SERVICE = "health"
    }
  }
  tags = var.tags
}

#Cloudwatch log group for products, order and health lambda functions 
resource "aws_cloudwatch_log_group" "products_log_group" {
  name = "/aws/lambda/${aws_lambda_function.products.function_name}"
  log_group_class = "STANDARD"
  retention_in_days = var.log_retention_days
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "orders_log_group" {
  name = "/aws/lambda/${aws_lambda_function.orders.function_name}"
  log_group_class = "STANDARD"
  retention_in_days = var.log_retention_days
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "health_log_group" {
  name = "/aws/lambda/${aws_lambda_function.health.function_name}"
  log_group_class = "STANDARD"
  retention_in_days = var.log_retention_days
  tags = var.tags
}