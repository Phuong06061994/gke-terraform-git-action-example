terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.14.0"
    }
  }
  backend "gcs" {
    bucket = "phuongnv63-terraform-state"  # GCS bucket where the state is stored
    prefix = "terraform/state" # Path in the bucket for state
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source     = "./modules/network"
  region     = var.region
  project_id = var.project_id
}

module "gke_cluster" {
  source = "./modules/gke"

  cluster_name       = "devops-gke-cluster-02"
  region             = var.region
  network_name       = module.network.vpc_id
  project_id         = var.project_id
  subnet_ip          = module.network.subnet_ip
  pod_range_name     = module.network.pod_range_name
  service_range_name = module.network.service_range_name
  depends_on = [
    module.network
  ]
}

