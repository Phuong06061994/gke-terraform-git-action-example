output "service_account_email" {
  value       = google_service_account.github_service_account.email
}

output "provider_name" {
  value = google_iam_workload_identity_pool_provider.github_provider.name
}

