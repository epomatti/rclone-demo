terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.0.0"
    }
  }
}

module "storage" {
  source          = "./modules/storage"
  bucket_location = var.bucket_location
  project_id      = var.project_id
}

module "network" {
  source = "./modules/network"
}
