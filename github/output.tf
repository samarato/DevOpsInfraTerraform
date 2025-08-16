# output "repository_url" {
#   description = "The URL of the GitHub repository"
#   value       = module.github_repo.repository_url
# }

output "repository_url" {
  value = github_repository.repo.html_url
}
