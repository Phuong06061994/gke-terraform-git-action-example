
# Create a Service Account
resource "google_service_account" "github_service_account" {
  account_id   = var.account_id        
  display_name = var.display_name
  project      = var.project_id
}
# Assign multiple roles to the service account
resource "google_project_iam_member" "role_binding" {
  for_each = toset(var.roles)  # Loop over the list of roles

  project = var.project_id    
  role    = each.value         
  member  = "serviceAccount:${google_service_account.github_service_account.email}"
}

# Workload Identity Pool
resource "google_iam_workload_identity_pool" "github_actions_pool" {
  workload_identity_pool_id = var.github_actions_pool_id
  display_name              = var.github_actions_pool_name
  description               = var.github_actions_pool_description
  
}

# Workload Identity Pool Provider
resource "google_iam_workload_identity_pool_provider" "github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_actions_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions-pool-demo"
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
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool_provider.github_provider.name}"
  ]
  depends_on = [ google_iam_workload_identity_pool_provider.github_provider ]
}

