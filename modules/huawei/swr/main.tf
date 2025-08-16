resource "huaweicloud_swr_organization" "swr_create" {
  region = var.swr.region
  name   = var.swr.environment
}


resource "huaweicloud_swr_image_retention_policy" "swr_set_image_retention" {
  depends_on = [huaweicloud_swr_organization.swr_create]
  for_each = {
    for repo in data.huaweicloud_swr_repositories.swr_current_repo.repositories : repo.name => repo
  }

  organization = var.swr.environment

  repository = each.value.name
  type       = "tag_rule"
  number     = 10
  tag_selectors {
    kind    = "regexp"
    pattern = "${var.swr.branch_name}**"
  }

  # tag_selectors {
  #   kind    = "label"
  #   pattern = "abc"
  # }
}

resource "huaweicloud_swr_organization_permissions" "swr_org_permissions" {
  depends_on = [huaweicloud_swr_organization.swr_create]
  for_each   = { for user in local.combined_user : user.user_id => user }

  organization = var.swr.environment

  dynamic "users" {
    for_each = [each.value] # Use a single user as a list for the dynamic block

    content {
      user_name  = users.value.username
      user_id    = users.value.user_id
      permission = users.value.permission
    }
  }
}
