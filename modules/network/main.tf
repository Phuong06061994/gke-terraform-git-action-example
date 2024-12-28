resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name_gke
  ip_cidr_range = var.subnet_range_ip
  region        = var.region
  network       = var.network_name

  secondary_ip_range {
    range_name    = var.service_range_name
    ip_cidr_range = var.service_range_ip
  }

  secondary_ip_range {
    range_name    = var.pod_range_name
    ip_cidr_range = var.pod_range_ip
  }
}
