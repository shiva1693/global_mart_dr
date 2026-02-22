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