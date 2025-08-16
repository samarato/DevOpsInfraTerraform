# modules/github_repo/main.tf

resource "github_repository" "repo" {
  name        = var.github_repo_name
  description = var.github_repo_description
  visibility  = var.github_repo_visibility
  auto_init   = var.github_auto_init
  has_issues  = var.github_has_issues
  has_wiki    = var.github_has_wiki
}


