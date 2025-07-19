output "ssm_start_session_command" {
  value = var.ec2_create_instance == true ? "aws ssm start-session --target ${module.instance[0].instance_id}" : null
}

output "rclone_bucket_domain_name" {
  value = module.bucket_rclone.bucket_domain_name
}
