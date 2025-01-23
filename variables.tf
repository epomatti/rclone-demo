variable "aws_region" {
  type = string
}

variable "workload" {
  type = string
}

### CloudFront ###
variable "cloudfront_create" {
  type = bool
}

variable "cloudfront_price_class" {
  type = string
}

variable "cloudfront_minimum_protocol_version" {
  type = string
}

### EC2 ###
variable "ec2_create_instance" {
  type = bool
}

variable "ec2_ami" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}
