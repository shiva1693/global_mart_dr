variable "primary_region" {
  description = "Primary AWS region for the DR setup"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
  type        = string
  default     = "global-mart-dr-terraform-state"
}

variable "lock_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
  default     = "global-mart-dr-terraform-locks"
}   

variable "project_name" {
  description = "Name of the project for tagging resources"
  type        = string
  default     = "global-mart-dr"
}

variable "tags"{
    description = "Additional tags to apply to all resources"
    type        = map(string)
    default     = {}
}

locals{
    common_tags =merge(
        {
            Project = var.project_name
            Environment = "dev"
        },
        var.tags
    )
}