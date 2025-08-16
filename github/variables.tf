variable "github_organization" {
  description = "github organization name"
  default     = "example"
  type        = string
}

variable "github_owner" {
  description = "GitHub account or organization owner"
  type        = string
  default     = "example"
}

variable "github_token" {
  description = "GitHub token for authentication please follow by readme.md"
  type        = string
}
variable "github_repo_name" {
  description = "The name of the GitHub repository"
  type        = string
}

variable "github_repo_visibility" {
  description = "The visibility of the GitHub repository"
  type        = string
}

variable "github_repo_description" {
  description = "The description of the GitHub repository"
  type        = string
}
