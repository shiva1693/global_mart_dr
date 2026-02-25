resource "aws_route53_zone" "api_dr" {
  name = "api.dr.thezxcvbnm.online"
  tags = var.tags
}