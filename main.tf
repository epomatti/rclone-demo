terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
module "bucket_oac" {
  source   = "./modules/bucket"
  workload = var.workload
}

module "cloudfront" {
  source                          = "./modules/cloudfront"
  workload                        = var.workload
  price_class                     = var.cloudfront_price_class
  oac_bucket_regional_domain_name = module.bucket_oac.bucket_regional_domain_name
  minimum_protocol_version        = var.cloudfront_minimum_protocol_version
}

module "s3_permissions" {
  source                      = "./modules/permissions"
  cloudfront_distribution_arn = module.cloudfront.distribution_arn
  oac_bucket_id               = module.bucket_oac.bucket_id
  oac_bucket_arn              = module.bucket_oac.bucket_arn
}
