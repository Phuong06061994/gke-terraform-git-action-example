# Output the Service Account Email
output "service_account_email" {
  value = module.workload_identity_pool.service_account_email
}

output "provider_name" {
  value = module.workload_identity_pool.provider_name
}

output "project_id" {
  value = var.project_id
}