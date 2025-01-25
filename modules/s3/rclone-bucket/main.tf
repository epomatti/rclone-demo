locals {
  random_affix = random_string.random_suffix.result
}

resource "random_string" "random_suffix" {
  length  = 3
  special = false
  upper   = false
}

resource "aws_s3_bucket" "main" {
  bucket        = "bucket-${var.workload}-${local.random_affix}"
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
