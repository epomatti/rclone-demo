locals {
  s3_origin_oac = "bucket-oac"
}

resource "aws_cloudfront_origin_access_identity" "main" {
  comment = "S3 CloudFront OAI"
}

resource "aws_cloudfront_origin_access_control" "main" {
  name                              = "oac-${var.workload}-bucket"
  description                       = "OAC authorization for S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  price_class     = var.price_class
  enabled         = true
  is_ipv6_enabled = true
  comment         = "Distribution for OAI and OAC bucket origins"

  # aliases = [var.workload]

  ### ORIGINS ###

  # OAC
  origin {
    domain_name = var.oac_bucket_regional_domain_name
    origin_id   = local.s3_origin_oac

    origin_access_control_id = aws_cloudfront_origin_access_control.main.id
  }


  ### BEHAVIORS ###

  ordered_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["HEAD", "GET"]
    target_origin_id       = local.s3_origin_oac
    path_pattern           = "/oac/*"
    viewer_protocol_policy = "redirect-to-https"

    # CachingDisabled managed policy
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3_origin_oac
    viewer_protocol_policy = "redirect-to-https"

    # CachingOptimized
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    # acm_certificate_arn            = var.acm_arn
    # minimum_protocol_version = var.minimum_protocol_version
    # ssl_support_method       = "sni-only"
  }
}

### Signed URLs stuff

# resource "aws_cloudfront_public_key" "default" {
#   comment     = "Signed URLs with Terraform"
#   encoded_key = file("${path.module}/../../keys/public.pem")
#   name        = "terraform-key"
# }

# resource "aws_cloudfront_key_group" "default" {
#   comment = "Signed URLs with Terraform"
#   items   = [aws_cloudfront_public_key.default.id]
#   name    = "terraform-key-group"
# }
