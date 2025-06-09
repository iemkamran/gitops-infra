resource "azurerm_kubernetes_cluster_extension" "flux" {
  name           = "flux"
  extension_type = "microsoft.flux"
  cluster_id     = var.cluster_id

  configuration_settings = {
    "gitRepository.url"          = var.git_repo_url
    "gitRepository.syncInterval" = "1m"
    "gitRepository.branch"       = var.git_branch
    "kustomization.path"         = var.git_repo_path
    "kustomization.prune"        = "true"
    "kustomization.interval"     = "1m"
  }
}