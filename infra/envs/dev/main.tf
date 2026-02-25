module "dynamodb" {
  source         = "../../modules/dynamodb"
  table_name     = "${var.name_prefix}-products"
  replica_region = var.secondary_region
  tags           = var.tags
}

module "iam" {
  source       = "../../modules/iam"
  name_prefix = var.name_prefix
  table_name   = module.dynamodb.products_table_name
  tags         = var.tags
}

module "lambda_primary" {
  source = "../../modules/lambda"
  name_prefix = var.name_prefix

  lambda_role_arn = module.iam.lambda_role_arn
  table_name = module.dynamodb.products_table_name
  environment = "dev"
  region = var.primary_region

  products_src_dir = "lambda/products"
  orders_src_dir = "lambda/orders"
  health_src_dir = "lambda/health"

  tags = var.tags
  log_retention_days = 30
}

module "lambda_secondary" {
  source = "../../modules/lambda"
  providers = { aws = aws.Secondary}
  name_prefix = var.name_prefix

  lambda_role_arn = module.iam.lambda_role_arn
  table_name = module.dynamodb.products_table_name
  environment = "dev"
  region = var.secondary_region

  products_src_dir = "/lambda/products"
  orders_src_dir = "/lambda/orders"
  health_src_dir = "/lambda/health"

  tags = var.tags
  log_retention_days = 30
}

module "api_gateway_primary" {
  source = "../../modules/apigw"

  name_prefix = var.name_prefix
  region = var.primary_region
  environment = "dev"
  stage_name = var.stage_name
  tags = var.tags

  health_lambda_invoke_arn = module.lambda_primary.health_lambda_invoke_arn
  products_lambda_invoke_arn = module.lambda_primary.products_lambda_invoke_arn
  orders_lambda_invoke_arn = module.lambda_primary.orders_lambda_invoke_arn
} 

module "apigw_secondary" {
  source    = "../../modules/apigw"
  providers = { aws = aws.Secondary }

  name_prefix = var.name_prefix
  tags        = var.tags
  environment = "dev"
  stage_name = var.stage_name
  region      = var.secondary_region

  health_lambda_invoke_arn   = module.lambda_secondary.health_lambda_invoke_arn
  products_lambda_invoke_arn = module.lambda_secondary.products_lambda_invoke_arn
  orders_lambda_invoke_arn   = module.lambda_secondary.orders_lambda_invoke_arn
}

module "dns_api" {
  source = "../../modules/dns_api"
  tags   = var.tags
}