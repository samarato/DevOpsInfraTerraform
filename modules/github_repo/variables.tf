# modules/github_repo/variables.tf

variable "github_repo_name" {
  description = "The name of the repository"
  type        = string
}

variable "github_repo_description" {
  description = "The description of the repository"
  type        = string
  default     = ""
}

variable "github_repo_visibility" {
  description = "The visibility of the repository (private or public)"
  type        = string
  default     = "private"
}

variable "github_auto_init" {
  description = "Create repository with initial commit"
  type        = bool
  default     = true
}

variable "github_has_issues" {
  description = "Enable issues for this repository"
  type        = bool
  default     = true
}

variable "github_has_wiki" {
  description = "Enable wiki for this repository"
  type        = bool
  default     = true
}

variable "github_token" {
  type        = string
  description = "GitHub Personal Access Token"
  default     = "" # Set default to empty
}

variable "github_owner" {
  type        = string
  description = "GitHub Owner"
  default     = "samarato" # Set default to empty
}
variable "github_organization" {
  type        = string
  description = "GitHub Owner"
  default     = "samarato" # Set default to empty
}
