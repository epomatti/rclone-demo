output "bucket_name" {
  value = module.storage.bucket_name
}

output "service_account_email" {
  value = module.iam.service_account_email
}
