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


### CloudFront Setup ###
module "bucket_oac" {
  count    = var.cloudfront_create ? 1 : 0
  source   = "./modules/s3/cloudfront-bucket-oac"
  workload = var.workload
}

module "cloudfront" {
  count                           = var.cloudfront_create ? 1 : 0
  source                          = "./modules/cloudfront"
  workload                        = var.workload
  price_class                     = var.cloudfront_price_class
  oac_bucket_regional_domain_name = module.bucket_oac[0].bucket_regional_domain_name
  minimum_protocol_version        = var.cloudfront_minimum_protocol_version
}

module "cloudfront_permissions" {
  count                       = var.cloudfront_create ? 1 : 0
  source                      = "./modules/permissions"
  cloudfront_distribution_arn = module.cloudfront[0].distribution_arn
  oac_bucket_id               = module.bucket_oac[0].bucket_id
  oac_bucket_arn              = module.bucket_oac[0].bucket_arn
}

### EC2 ###
module "vpc" {
  count      = var.ec2_create_instance ? 1 : 0
  source     = "./modules/vpc"
  aws_region = var.aws_region
  workload   = var.workload
}

module "instance" {
  count         = var.ec2_create_instance ? 1 : 0
  source        = "./modules/instance"
  workload      = var.workload
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  vpc_id        = module.vpc[0].vpc_id
  subnet_id     = module.vpc[0].default_public_subnet_id
}
