output "ssm_start_session_command" {
  value = var.ec2_create_instance == true ? "aws ssm start-session --target ${module.instance.instance_id}" : null
}
