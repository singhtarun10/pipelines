Intern Project: Azure Cloud Infrastructure & CI/CD Implementation
🎯 Objective
Deploy a complete cloud environment using Terraform and configure CI/CD pipelines using Azure DevOps for:
A Node.js Web Application (App Service)
A Containerized Application (Docker → AKS)

🔧 Task 1: Infrastructure Deployment with Terraform
✅ Overview
Provision the following using Terraform:
Azure Storage Account
Azure Key Vault
Azure SQL Database
Azure Web App
Azure Kubernetes Service (AKS)
Azure Container Registry (ACR)
✅ Best Practices
Each resource has its own reusable module
Sensitive values stored in Key Vault (e.g., DB password)
Remote state stored in Azure Storage Account
No hardcoded credentials in code
🔁 Steps
Storage Account Setup (done manually):
Container: tfstate
Enable versioning
Configure Remote Backend: backend.tf
Create Modules: for keyvault, sql-db, web_app, aks, acr
Configure Pipelines:
terraform-prod.yml for CI/CD with the following stages:
Terraform Init
Terraform Plan (on all branches)
Terraform Apply (only on main, gated by approval)
PR triggers enforced in YAML
🚀 Task 2: CI/CD Pipeline Setup
1. Web App CI/CD
Pipeline File: azure-pipelines-webapp.yml
Stages:
Install, Build & Test (Node.js)
Zip Artifact and Publish
Deploy to Azure Web App
Dev → QA → Stage → Prod (multi-stage)
Uses: AzureWebApp@1, zip deployment method
Startup Command: npm run start
2. Docker to AKS CI/CD
Pipeline File: azure-pipelines-aks.yml
Stages:
Build Docker Image & Push to ACR (based on environment)
Deploy to AKS using kubectl via KubernetesManifest@0
Multi-environment support via parameters.environment
ImagePullSecrets created per environment
Kubernetes Manifests: environment-specific deployments
✅ Pipeline Features
Azure DevOps multi-stage pipelines
Environment approvals using Azure DevOps Environments
Branch policies (PR checks) enforced in YAML
Secure secrets via Key Vault (no hardcoded values)
Reusable modules and clean separation of concerns
