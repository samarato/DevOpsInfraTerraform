terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.2.3"
    }
  }
}
provider "github" {
  token = var.github_token != "" ? var.github_token : null
  owner = var.github_organization

}
