data "huaweicloud_swr_organizations" "swr_current" {
  name = var.swr.environment
}

data "huaweicloud_swr_repositories" "swr_current_repo" {
  region       = var.swr.region
  organization = var.swr.environment
}

data "huaweicloud_identity_users" "identity_users" {
  for_each = toset(var.swr_user.usernames) # Convert the list to a set for uniqueness

  name = each.key # Each username in the list  
}

