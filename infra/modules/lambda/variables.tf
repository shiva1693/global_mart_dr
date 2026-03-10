variable "name_prefix" { type = string }
variable "tags" { type = map(string) }
variable "lambda_role_arn" { type = string }
variable "table_name" { type = string }
variable "environment" { 
    type = string
    default = "dev" 
}
variable "region" { type = string }
variable "log_retention_days" { 
    type = number 
    default = 30 
}

variable "products_src_dir" { type = string }
variable "orders_src_dir" { type = string }
variable "health_src_dir" { type = string }
