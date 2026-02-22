variable "primary_region" {
  description = "Primary AWS region for the DR setup"
  type        = string
  default     = "us-east-1"
}

variable "secondary_region" {
  description = "Secondary AWS region for the DR setup"
  type        = string
  default     = "us-west-2"
}

variable "name_prefix" {
    description = "Prefix for naming AWS resources"
    type        = string
    default     = "globalmart-dr-dev"
}

variable "tags" {
    type = map(string)
    default = {
        Project = "global-mart-dr"
        Environment = "dev"
        owner = "terraform-owned"
    }
}