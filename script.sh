#!/bin/bash

# Initialize Terraform and apply the configuration
cd workload-pool
terraform init
terraform apply -auto-approve -var-file="../terraform.tfvars"

# Capture output from Terraform
SERVICE_ACCOUNT_EMAIL=$(terraform output -raw service_account_email)
PROVIDER_NAME=$(terraform output -raw provider_name)
GITHUB_REPOSITORY=$(terraform output -raw github_repository)

# Check the captured values
echo "Service Account Email: $SERVICE_ACCOUNT_EMAIL"
echo "Provider Name: $PROVIDER_NAME"
echo "GitHub Repository: $GITHUB_REPOSITORY"

# Set GitHub secrets
gh secret set SERVICE_ACCOUNT_EMAIL --body "$SERVICE_ACCOUNT_EMAIL" --repos "$GITHUB_REPOSITORY"
gh secret set PROVIDER_NAME --body "$PROVIDER_NAME" --repos "$GITHUB_REPOSITORY"
