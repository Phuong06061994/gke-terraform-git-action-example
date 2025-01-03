output "service_account_email" {
  value       = google_service_account.github_service_account.email
}

output "provider_name" {
  value = google_iam_workload_identity_pool_provider.github_provider.name
}

output "github_repository" {
  value = var.github_repository
}

output "region" {
  value = var.region
}

output "project_id" {
  value = var.project_id
}