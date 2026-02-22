terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0.0"
    }
  }
}

provider "aws" {
    alias = "Primary"
    region = var.primary_region
}

provider "aws" {
    alias = "Secondary"
    region = var.secondary_region
}

