variable "workload" {
  type = string
}

variable "ec2_auto_config_rclone" {
  type = bool
}

variable "ssm_rcloud_access_key_id" {
  type = string
}

variable "ssm_rcloud_access_key_secret" {
  type      = string
  sensitive = true
}
