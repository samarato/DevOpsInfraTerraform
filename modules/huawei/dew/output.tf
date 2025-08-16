# output "output_dew_kms_current_key_alias" {
#   value = data.huaweicloud_kms_key.dew_kms_current_key_alias
# }
output "output_data_kms_current_keypair" {
  value = huaweicloud_kms_key.dew_kms_alias
}

# output "output_kms_current_keypair_name" {
#   value = huaweicloud_kps_keypair.kps_keypair.name
# }

# output "output_kms_current_cce_keypair_name" {
#   value = data.huaweicloud_kps_keypairs.dew_kms_current_keypair.name
# }
output "output_kms_current_cce_keypair_name" {
  value = huaweicloud_kps_keypair.cce_keypair.name
}

output "output_user_ids" {
  value = data.huaweicloud_identity_users.identity_users
}