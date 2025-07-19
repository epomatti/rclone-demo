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
}

module "network" {
  source = "./modules/network"
}
