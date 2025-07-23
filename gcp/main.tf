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
  network_name          = module.network.network_name
  network_id            = module.network.network_id
  subnetwork_id         = module.network.instances_subnetwork_id
}

module "iam" {
  source      = "./modules/iam"
  bucket_name = module.storage.bucket_name
}
