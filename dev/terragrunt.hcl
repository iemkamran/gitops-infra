include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = "dev-rg"
  cluster_name       = "dev-aks-cluster"
  git_repo_url       = "https://github.com/your-org/your-repo.git"
  git_branch         = "develop"
  git_repo_path      = "clusters/dev"
}