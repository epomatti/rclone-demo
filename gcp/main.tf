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

module "rclone_instance" {
  source                = "./modules/instance"
  instance_image        = var.instance_image
  instance_machine_type = var.instance_machine_type
  instance_zone         = var.instance_zone
}
