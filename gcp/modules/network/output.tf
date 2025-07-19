output "network_name" {
  value = google_compute_network.default.name
}

output "network_id" {
  value = google_compute_network.default.id
}

output "instances_subnetwork_id" {
  value = google_compute_subnetwork.instances.id
}
