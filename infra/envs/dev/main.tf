module "dynamodb" {
  source         = "../../modules/dynamodb"
  table_name     = "${var.name_prefix}-products"
  replica_region = var.secondary_region
  tags           = var.tags
  
}
