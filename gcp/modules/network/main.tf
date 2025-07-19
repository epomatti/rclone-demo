resource "google_compute_network" "default" {
  name                    = "vpc-rclone"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "instances" {
  name          = "rclone-subnet"
  ip_cidr_range = "10.0.0.0/24"
  # region        = "us-central1"
  network = google_compute_network.default.id
  # secondary_ip_range {
  #   range_name    = "tf-test-secondary-range-update1"
  #   ip_cidr_range = "192.168.10.0/24"
  # }
}
