resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksflux"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_a2_v2"
  }

  identity {
    type = "SystemAssigned"
  }


}
