# data "huaweicloud_kms_key" "dew_kms_current_key_alias" {
#   key_alias             = "kms-${var.dew.service_prefix}-${var.dew.environment}"
#   enterprise_project_id = var.dew.eps_project_id
# }

data "huaweicloud_kps_keypairs" "dew_kms_current_keypair" {
  name = "kps2-cce-${var.dew.environment}"
}

data "huaweicloud_identity_users" "identity_users" {
  for_each = toset(var.dew.usernames) # Convert the list to a set for uniqueness

  name = each.key # Each username in the list  
}

