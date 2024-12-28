
source .env
# Initialize Terraform and apply the configuration
terraform init
terraform apply -target="module.workload-identity-pool" -auto-approve -var="project_id=$PROJECT_ID" -var="region=$REGION" -var="github_repository=$GITHUB_REPOSITORY"

echo "This is my output from terraform"
# Capture output from Terraform
$SERVICE_ACCOUNT_EMAIL = terraform output -raw service_account_email
$PROVIDER_NAME = terraform output -raw provider_name

echo $GITHUB_REPOSITORY

# Set GitHub secrets
gh secret set SERVICE_ACCOUNT_EMAIL --body "111" --repos "$GITHUB_REPOSITORY"
gh secret set PROVIDER_NAME --body "2222" --repos "$GITHUB_REPOSITORY"

# Confirm success
Write-Host "Secrets created successfully in $GITHUB_REPOSITORY."
