
variable "project_id" {
  type = string
}
variable "account_id" {
  type = string
  default = "git-hub"
}

variable "display_name" {
  type = string
  default = "git hub account"
}

# List of roles to assign to the service account
variable "roles" {
  default = [
    "roles/storage.admin",
    "roles/iam.workloadIdentityPoolAdmin",
    "roles/container.admin",
    "roles/iam.workloadIdentityPoolAdmin",
    "roles/iam.serviceAccountAdmin"
  ]
}

variable "github_actions_pool_id" {
  default = "github-actions-pool-demo"
}

variable "github_actions_pool_name" {
  default = "GitHub Actions Pool"
}

variable "github_actions_pool_description" {
  default = "Workload Identity Pool for GitHub Actions"
}


variable "provider_id" {
  type = string
  default = "github-provider-demo"
}

variable "provider_name" {
  type = string
  default = "GitHub Provider"
}
variable "github_repository" {
  type = string
}