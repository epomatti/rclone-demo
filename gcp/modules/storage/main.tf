resource "google_storage_bucket" "rclone" {
  name          = "rclone-bucket-${var.project_id}"
  location      = var.bucket_location
  force_destroy = true

  uniform_bucket_level_access = true
}
