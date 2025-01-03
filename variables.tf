variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region for the VPC"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC"
  type        = string
  default     = "gke-demo-vpc"
}

variable "github_repository" {
  type = string
}
