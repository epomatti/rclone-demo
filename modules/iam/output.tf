output "rcloud_access_key_id" {
  value = aws_iam_access_key.rcloud.id
}

output "rcloud_access_key_secret" {
  value     = aws_iam_access_key.rcloud.secret
  sensitive = true
}
