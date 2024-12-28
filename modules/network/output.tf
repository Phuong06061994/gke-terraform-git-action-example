output "vpc_id" {
  description = "The ID of the VPC network"
  value       = google_compute_network.vpc.id
}

output "vpc_name" {
  description = "The ID of the VPC network"
  value       = google_compute_network.vpc.name
}

output "pod_range_name" {
  value = google_compute_subnetwork.subnet.secondary_ip_range[0].range_name
}

output "service_range_name" {
  value = google_compute_subnetwork.subnet.secondary_ip_range[1].range_name
}

output "subnet_ip" {
  value = google_compute_subnetwork.subnet.id
}

