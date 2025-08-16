
module "github_repo" {
  source                  = "../modules/github_repo"
  github_repo_name        = var.github_repo_name
  github_repo_description = var.github_repo_description
  github_repo_visibility  = var.github_repo_visibility
  github_owner            = var.github_organization
  github_token            = var.github_token
}


