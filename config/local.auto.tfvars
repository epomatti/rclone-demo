# General
aws_region = "us-east-2"
workload   = "rclone"

### EC2 ###
ec2_create_instance    = true
ec2_auto_config_rclone = false
ec2_ami                = "ami-0ac5d9e789dbb455a"
ec2_instance_type      = "t4g.small"

### CloudFront ###
# cloudfront_create                   = false
# cloudfront_price_class              = "PriceClass_100"
# cloudfront_minimum_protocol_version = "TLSv1.2_2021"
