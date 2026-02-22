resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = var.state_bucket_name
  force_destroy = false
  tags = merge(local.common_tags, {
    Name = var.state_bucket_name
  })
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_bucket_encryption" {
    bucket = aws_s3_bucket.tf_state_bucket.id
    rule{
        apply_server_side_encryption_by_default{
            sse_algorithm = "AES256"
        }
    }
}

resource "aws_s3_bucket_public_access_block" "tf_state_public_access_block" {
    bucket = aws_s3_bucket.tf_state_bucket.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
    lifecycle {
          prevent_destroy = true
    }
}
