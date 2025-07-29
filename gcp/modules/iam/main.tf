resource "google_service_account" "rclone" {
  account_id   = "rclone-service-account"
  display_name = "rclone"
}

resource "google_project_iam_custom_role" "rclone_sync_role" {
  role_id     = "rcloneObjectSync"
  title       = "Rclone Sync"
  description = "Can sync objects in GCS buckets"

  permissions = [
    "storage.objects.create",
    "storage.objects.delete"
  ]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam
resource "google_storage_bucket_iam_member" "rclone_sync" {
  bucket = var.bucket_name
  role   = google_project_iam_custom_role.rclone_sync_role.name
  member = "serviceAccount:${google_service_account.rclone.email}"

  #   condition {
  #   title       = "limit-to-prefix"
  #   description = "Allow write only to uploads/ prefix"
  #   expression  = "resource.name.startsWith('projects/_/buckets/${google_storage_bucket.example.name}/objects/uploads/')"
  # }
}

# # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam
# resource "google_storage_bucket_iam_member" "rclone_write_only" {
#   bucket = var.bucket_name
#   role   = "roles/storage.objectCreator"
#   member = "serviceAccount:${google_service_account.rclone.email}"

#   #   condition {
#   #   title       = "limit-to-prefix"
#   #   description = "Allow write only to uploads/ prefix"
#   #   expression  = "resource.name.startsWith('projects/_/buckets/${google_storage_bucket.example.name}/objects/uploads/')"
#   # }
# }

# resource "google_storage_bucket_iam_member" "rclone_delete" {
#   bucket = var.bucket_name
#   role   = "roles/storage.objectViewer"
#   member = "serviceAccount:${google_service_account.rclone.email}"

#   #   condition {
#   #   title       = "limit-to-prefix"
#   #   description = "Allow write only to uploads/ prefix"
#   #   expression  = "resource.name.startsWith('projects/_/buckets/${google_storage_bucket.example.name}/objects/uploads/')"
#   # }
# }

# resource "google_storage_bucket_iam_member" "rclone_viewer" {
#   bucket = var.bucket_name
#   role   = "roles/storage.objectViewer"
#   member = "serviceAccount:${google_service_account.rclone.email}"

#   #   condition {
#   #   title       = "limit-to-prefix"
#   #   description = "Allow write only to uploads/ prefix"
#   #   expression  = "resource.name.startsWith('projects/_/buckets/${google_storage_bucket.example.name}/objects/uploads/')"
#   # }
# }
