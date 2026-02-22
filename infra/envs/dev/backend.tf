terraform {
  backend "s3" {
    bucket = "global-mart-dr-terraform-state"
    key    = "globalmart-dr/dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}
