 GKE Terraform GitHub Actions Example

This repository demonstrates how to deploy Google Kubernetes Engine (GKE) clusters using Terraform and automate the process through GitHub Actions. The workflow includes two primary flows:

1. **Workload Identity Provider & Service Account Creation**
2. **GKE Cluster Deployment**

---

## Prerequisites

Before using this repository, ensure you have the following:

- A Google Cloud Platform (GCP) project.
- Terraform installed on your local machine.
- A GitHub repository to use with Workload Identity.
- Enabled the required APIs on GCP:
  - Kubernetes Engine API
  - IAM API
  - Cloud Resource Manager API

---

## Quick Start Guide

### 1. Create terraform.tfvars

Define your variables in a terraform.tfvars file to simplify the process. Here’s an example:

hcl
project_id         = "<YOUR_GCP_PROJECT_ID>"
region             = "<YOUR_REGION>"
github_repository  = "<YOUR_GITHUB_USERNAME/REPOSITORY_NAME>"



- **project_id**: Your Google Cloud project ID.
- **region**: The region where resources will be deployed (e.g., us-central1).
- **github_repository**: The GitHub repository name for Workload Identity binding (e.g., Phuong06061994/gke-terraform-git-action-example).

### 2. Flows

#### Flow 1: Workload Identity Provider & Service Account
This flow automates the creation of:
- A Workload Identity Provider for GitHub Actions.
- A Google Cloud Service Account.
- IAM bindings between the Workload Identity Provider and Service Account.

**How to Run:**

1. Create the terraform.tfvars file.
2. Run the script.sh script to create the Workload Identity Provider and Service Account:
   

bash
   ./script.sh



#### Flow 2: GKE Cluster Deployment
This flow automates the deployment of a GKE cluster using Terraform.

**How to Run:**

1. Push or merge changes to the main branch.
2. The deploy.yml in .github/workflows will execute.

---

### 3. Usage

1. Clone this repository:
   

bash
   git clone https://github.com/Phuong06061994/gke-terraform-git-action-example.git
   cd gke-terraform-git-action-example



2. Set up the required variables in terraform.tfvars.

3. Run the script.sh script to create the Workload Identity Provider and Service Account:
   

bash
   ./script.sh



4. Push changes to the main branch to trigger the GitHub Actions workflows.

---

## Notes

- Ensure your GitHub repository has the necessary permissions to trigger workflows.
- Monitor the workflows in the "Actions" tab of your GitHub repository for progress and debugging.

---
