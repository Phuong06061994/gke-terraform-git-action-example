variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region for the VPC"
  type        = string
  default = "asia-southeast1"
}

variable "network_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_range_ip" {
  type = string
  default = "10.0.104.0/24"
}

variable "pod_range_name" {
  type = string
  default = "pod-range-name"
}

variable "pod_range_ip" {
  type = string
  default = "192.168.1.0/24"
}

variable "service_range_name" {
  type = string
  default = "service-range-name"
}

variable "service_range_ip" {
  type = string
  default = "192.168.64.0/22"
}

variable "subnet_name_gke" {
  type = string
  default = "subnet-gke"
}