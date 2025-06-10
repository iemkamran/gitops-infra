# Terraform + Terragrunt AKS & Flux Deployment

This repository contains Terraform modules and Terragrunt configurations to deploy an Azure Kubernetes Service (AKS) cluster with Flux GitOps integration. It also includes infrastructure to provision a remote backend storage account for Terraform state management.

---

## Folder Structure
```bash
infrastructure/
├── backend/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ └── terragrunt.hcl
│
├── modules/
│ ├── aks/
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ └── outputs.tf
│ │
│ └── flux/
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
│
├── dev/
│ └── terragrunt.hcl
│
├── prod/
│ └── terragrunt.hcl
│
└── terragrunt.hcl
```


## Modules Description

### `backend/`

- Provisions Azure Storage Account, Resource Group, and Blob Container for Terraform remote state.
- Acts as the remote backend for Terraform state files.
- Managed via Terragrunt to ensure consistent and automated deployment.

### `modules/aks/`

- Terraform module to deploy the Azure Kubernetes Service (AKS) cluster.
- Manages cluster configuration, node pools, networking, and identity.

### `modules/flux/`

- Terraform module to deploy Flux GitOps onto the AKS cluster.
- Configures Flux to sync from your Git repository to the cluster continuously.

### `dev/` and `prod/`

- Environment-specific Terragrunt configurations.
- Consume modules and pass environment-specific variables like resource group names, cluster names, Git repo URLs, etc.
- Use these folders to manage separate infrastructure stacks for development and production.
---

## App Deployment via Flux

Flux is configured to deploy workloads from:

> 📦 [https://github.com/iemkamran/gitops-app](https://github.com/iemkamran/gitops-app)

Your Flux module will create:

```yaml
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: GitRepository
metadata:
  name: gitops-app
  namespace: flux-system
spec:
  interval: 1m
  url: https://github.com/iemkamran/gitops-app
  branch: main
```

```
apiVersion: kustomize.toolkit.fluxcd.io/v1beta2
kind: Kustomization
metadata:
  name: gitops-app
  namespace: flux-system
spec:
  interval: 1m
  path: ./apps
  prune: true
  sourceRef:
    kind: GitRepository
    name: gitops-app
```
✅ Flux watches for changes to the repo and deploys/updates apps automatically on AKS.
---

## Deployment Steps

### 1. Deploy Remote Backend (Only once)

```bash
cd infrastructure/backend
terragrunt apply
```
This sets up the Azure Storage Account and Blob Container used as a remote backend.

### 2. Deploy AKS and Flux (Dev)
```bash
cd ../dev
terragrunt apply
```
This does:

- AKS cluster provisioning
- Flux installation on AKS
- Flux bootstrap with your Git repo
- Automatic deployment of manifests from gitops-app

3. Deploy Production (Optional)
```bash
cd ../prod
terragrunt apply
```
Use this to deploy a separate AKS cluster + Flux configuration for production.

### Requirements
- Azure CLI authenticated (az login)
- Set the following environment variables for Terraform:

```bash
export ARM_SUBSCRIPTION_ID=your-subscription-id
export ARM_CLIENT_ID=your-client-id
export ARM_CLIENT_SECRET=your-client-secret
export ARM_TENANT_ID=your-tenant-id
```
- Terraform >= 1.3
- Terragrunt >= 0.50

