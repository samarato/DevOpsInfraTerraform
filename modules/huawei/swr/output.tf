output "output_swr_org_current" {
  value = data.huaweicloud_swr_organizations.swr_current
}

output "output_swr_org_permission" {
  value = huaweicloud_swr_organization_permissions.swr_org_permissions
}

# output "print_combined_user" {
#   value = local.combined_user
# }
# output "print_id_users" {
#   value = data.huaweicloud_identity_users.identity_users
# }