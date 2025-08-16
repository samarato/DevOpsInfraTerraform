# Create a new list combining repositories and users
locals {
  combined_info = [
    for repo in data.huaweicloud_swr_repositories.swr_current_repo.repositories : {
      repository_name = repo.name
      users = [
        for user in data.huaweicloud_identity_users.identity_users : {
          username   = user.users[0].name
          user_id    = user.users[0].id
          permission = var.swr_user.permission
        }
      ]
    }
  ]

  combined_user = [
    for user in data.huaweicloud_identity_users.identity_users : {
      username   = user.users[0].name
      user_id    = user.users[0].id
      permission = var.swr_user.permission
    }
  ]
}
