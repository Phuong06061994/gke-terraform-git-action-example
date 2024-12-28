
resource "google_container_cluster" "primary" {
  name                     = var.cluster_name
  location                 = var.region
  networking_mode          = "VPC_NATIVE"
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false
  network                  = var.network_name
  subnetwork               = var.subnet_ip
  ip_allocation_policy {
    cluster_secondary_range_name  = var.pod_range_name
    services_secondary_range_name = var.service_range_name

  }
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "my-node" {
  name       = var.node_name
  cluster    = google_container_cluster.primary.name
  location   = var.region
  node_count = var.node_count
  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  depends_on = [google_container_cluster.primary]
}

