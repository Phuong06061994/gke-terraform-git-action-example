
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.14.0"
    }
  }
  backend "gcs" {
    bucket = "phuongnv63-terraform-state"  # GCS bucket where the state is stored
    prefix = "terraform/workload-pool" # Path in the bucket for state
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Create a Service Account
resource "google_service_account" "github_service_account" {
  account_id   = var.account_id        
  display_name = var.display_name
}
# Assign multiple roles to the service account
resource "google_project_iam_member" "role_binding" {
  for_each = toset(var.roles)  # Loop over the list of roles

  project = var.project_id    
  role    = each.value         
  member  = "serviceAccount:${google_service_account.github_service_account.email}"
}

resource "random_id" "random_number" {
  byte_length = 3  # 3 bytes generate 6 characters in hexadecimal format
}

resource "google_iam_workload_identity_pool" "github_actions_pool" {
  workload_identity_pool_id = "${var.github_actions_pool_id}-${random_id.random_number.hex}"
  display_name             = var.github_actions_pool_name
  description              = var.github_actions_pool_description
}

# Workload Identity Pool Provider
resource "google_iam_workload_identity_pool_provider" "github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_actions_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id
  display_name                       = var.provider_name
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }

  # Define the condition (in CEL)
  attribute_condition = "attribute.repository == '${var.github_repository}'"
  depends_on = [ google_iam_workload_identity_pool_provider.github_provider ]
}

# Service Account Binding for Workload Identity
resource "google_service_account_iam_binding" "workload_identity_binding" {
  service_account_id = google_service_account.github_service_account.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions_pool.name}/attribute.repository/${var.github_repository}"
  ]
  depends_on = [ google_iam_workload_identity_pool_provider.github_provider ]
}

