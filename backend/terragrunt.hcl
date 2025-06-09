terraform {
  source = "."
}

inputs = {
  resource_group_name  = "tfstate-rg"
  location             = "eastus"
  storage_account_name = "terragruntaksflux"  # must be globally unique
  container_name       = "tfstate"
  subscription_id      = "Add your subscription_id"
}