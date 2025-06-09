include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "prod-rg"
  cluster_name       = "prod-aks-cluster"
  git_repo_url       = "https://github.com/your-org/your-repo.git"
  git_branch         = "main"
  git_repo_path      = "clusters/prod"
}