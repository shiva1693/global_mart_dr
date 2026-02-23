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