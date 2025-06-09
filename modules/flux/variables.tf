variable "cluster_id" {
  type        = string
  description = "AKS Cluster ID"
}

variable "git_repo_url" {
  type        = string
}

variable "git_branch" {
  type        = string
  default     = "main"
}

variable "git_repo_path" {
  type        = string
  default     = "./"
}
