resource "google_service_account" "rclone" {
  account_id   = "rclone-service-account"
  display_name = "rclone"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam
resource "google_storage_bucket_iam_member" "rclone_write_only" {
  bucket = var.bucket_name
  role   = "roles/storage.objectCreator"
  member = "serviceAccount:${google_service_account.rclone.email}"

  #   condition {
  #   title       = "limit-to-prefix"
  #   description = "Allow write only to uploads/ prefix"
  #   expression  = "resource.name.startsWith('projects/_/buckets/${google_storage_bucket.example.name}/objects/uploads/')"
  # }
}
