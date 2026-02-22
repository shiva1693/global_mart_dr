variable "table_name" { type = string }
variable "tags" { type = map(string) }
variable "replica_region" { type = string }

resource "aws_dynamodb_table" "products" {
  name             = var.tags["Project"] != null ? "${var.tags["Project"]}-products" : "products"
  hash_key         = "pk"
  range_key        = "sk"
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }
  
  replica {
    region_name = var.replica_region
  }

    tags = var.tags
}

output "products_table_name" { value = aws_dynamodb_table.products.name }