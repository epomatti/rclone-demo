resource "google_storage_bucket" "rclone" {
  name          = "rclone-bucket"
  location      = var.bucket_location
  force_destroy = true

  uniform_bucket_level_access = true
}
