terraform {
  backend "azurerm" {}
}


module "aks" {
  source              = "./aks"
  resource_group_name = var.resource_group_name
  location            = var.location
  cluster_name        = var.cluster_name
}

module "flux" {
  source            = "./flux"
  cluster_id        = module.aks.cluster_id
  git_repo_url      = var.git_repo_url
  git_branch        = var.git_branch
  git_repo_path     = var.git_repo_path
}
