variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "region" {
  description = "The region for the GKE Cluster"
  type        = string
}

variable "node_name" {
  type = string
  default = "my-node"
}
variable "subnet_ip" {
  type = string
}
variable "pod_range_name" {
  type =  string
}
variable "service_range_name" {
  type =  string
}
variable "network_name" {
  type = string
  description = "network name"
}

variable "disk_size_gb" {
  type = number
  default = 10
}

variable "machine_type" {
  default = "e2-medium"
}
variable "zone" {
  description = "Zone for zonal resources"
  type        = string
  default     = "asia-southeast1-a"
}
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}
variable "node_count" {
  default = 1
}