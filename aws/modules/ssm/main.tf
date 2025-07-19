resource "aws_ssm_parameter" "rcloud_auto_config" {
  name  = "/rcloud/auto-config"
  type  = "String"
  value = var.ec2_auto_config_rclone
}

resource "aws_ssm_parameter" "rcloud" {
  name = "/rcloud/access-key"
  type = "SecureString"

  value = jsonencode({
    "id" : "${var.ssm_rcloud_access_key_id}",
    "secret" : "${var.ssm_rcloud_access_key_secret}"
  })
}
