variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "health_lambda_invoke_arn" {
  description = "Invoke ARN for the health Lambda function"
  type        = string
}

variable "products_lambda_invoke_arn" {
  description = "Invoke ARN for the products Lambda function"
  type        = string
}

variable "orders_lambda_invoke_arn" {
  description = "Invoke ARN for the orders Lambda function"
  type        = string
}

variable "stage_name" {
  description = "Stage name for the API Gateway"
  type        = string
}