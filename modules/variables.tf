variable "resource_group_name" {
  type        = string
  description = "Resource group for AKS"
}

variable "location" {
  type        = string
  description = "Location of AKS cluster"
}

variable "cluster_name" {
  type        = string
  description = "AKS cluster name"
}

variable "git_repo_url" {
  type        = string
  description = "Git repo for Flux"
}

variable "git_branch" {
  type        = string
  description = "Branch for Flux"
  default     = "main"
}

variable "git_repo_path" {
  type        = string
  description = "Path in repo for Flux"
  default     = "./"
}