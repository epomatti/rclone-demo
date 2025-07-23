resource "google_service_account" "rclone" {
  account_id   = "rclone-service-account"
  display_name = "rclone"
}

resource "google_storage_bucket_iam_member" "rclone_write_only" {
  bucket = var.bucket_name
  role   = "roles/storage.objectCreator"
  member = "serviceAccount:${google_service_account.rclone.email}"
}
