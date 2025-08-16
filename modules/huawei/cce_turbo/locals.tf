# # Create a new list combining repositories and users
# locals {
#   combined_info = [
#     for repo in data.huaweicloud_swr_repositories.swr_current_repo.repositories : {
#       repository_name = repo.name
#       users = [
#         for user in data.huaweicloud_identity_users.identity_users : {
#           username   = user.users[0].name
#           user_id    = user.users[0].id
#           permission = var.swr_user.permission
#         }
#       ]
#     }
#   ]

#   combined_user = [
#     for user in data.huaweicloud_identity_users.identity_users : {
#       username   = user.users[0].name
#       user_id    = user.users[0].id
#       permission = var.swr_user.permission
#     }
#   ]
# }
# output "print_combined_user" {
#   value = local.combined_user
# }
# output "print_id_users" {
#   value = data.huaweicloud_identity_users.identity_users
# }

locals {
  cce_private_ip = try(regex("https://([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}):[0-9]+", huaweicloud_cce_cluster.cce_create.certificate_clusters[0].server)[0], "")
  cce_public_ip  = try(huaweicloud_nat_dnat_rule.cce_nat_eip.floating_ip_address, "")
}