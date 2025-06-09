terraform {
  source = "../modules/"  # Path to your Terraform root module
}

remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate-rg"          # backend RG for all envs
    storage_account_name = "terragruntaksflux"  # backend storage account
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}

inputs = {
  location = "East US"  # default, can be overridden in env
}