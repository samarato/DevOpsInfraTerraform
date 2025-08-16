resource "huaweicloud_kms_key" "dew_kms_alias" {
  key_alias             = "${var.prefix}-kms5-${var.dew.environment}"
  enterprise_project_id = var.dew.eps_project_id
  key_algorithm         = "AES_256"
  key_usage             = "ENCRYPT_DECRYPT"
  tags = {
    environment = var.dew.environment
    service     = var.dew_tag_service
  }

  # lifecycle {
  #   prevent_destroy = true
  # }
}

# resource "huaweicloud_csms_secret" "csms_create" {
#   # count = length(var.dew_csms.name) > 0 ? 1 : 0

#   name = "csms-${var.dew_csms.name}-${var.dew.environment}"
#   secret_text = jsonencode({
#     (var.dew_csms.secret_key_public)  = file(var.dew_csms.secret_value_public)
#     (var.dew_csms.secret_key_private) = file(var.dew_csms.secret_value_private)
#   })
#   description           = "Private key for access ECS"
#   kms_key_id            = huaweicloud_kms_key.dew_kms_alias.key_id
#   enterprise_project_id = var.dew.eps_project_id
#   tags = {
#     environment = var.dew.environment
#     service     = var.dew_tag_service
#   }

#   lifecycle {
#     prevent_destroy = true
#   }
# }
# data "huaweicloud_csms_secrets" "test" {
#   name = "csms-${var.dew_csms.name}-${var.dew.environment}"
# }
# output "output_test_get_secret" {
#   value = data.huaweicloud_csms_secrets.test
# }
# output "output_secret_value" {
#   value     = length(huaweicloud_csms_secret.csms_create) > 0 ? huaweicloud_csms_secret.csms_create.secret_text : ""
#   sensitive = true
# }
# data "huaweicloud_kms_grants" "test" {
#   key_id = huaweicloud_kms_key.dew_kms_alias.key_id
# }
# output "out-key_id" {
#   value = data.huaweicloud_kms_grants.test
# }

# resource "huaweicloud_kms_grant" "grant_kms" {
#   depends_on = [huaweicloud_kms_key.dew_kms_alias]
#   for_each = {
#     for user in data.huaweicloud_identity_users.identity_users : user.id => user
#   }

#   key_id            = huaweicloud_kms_key.dew_kms_alias.key_id
#   name              = each.value.name
#   type              = "user"
#   grantee_principal = each.value.id #each.key #each.value.id
#   operations        = ["encrypt-data", "decrypt-data", "get-publickey", "retire-grant"]
#   # [
#   #   "create-datakey",
#   #   "create-datakey-without-plaintext",
#   #   "encrypt-datakey",
#   #   "decrypt-datakey",
#   #   "describe-key",
#   #   "create-grant",
#   #   "retire-grant",
#   #   "encrypt-data",
#   #   "decrypt-data"
#   # ]
#   retiring_principal = each.value.id #each.key
# }

resource "huaweicloud_kps_keypair" "cce_keypair" {
  # for_each = {
  #   for user in data.huaweicloud_identity_users.identity_users : user.id => user
  # }
  name            = "kps-cce13-${var.dew.environment}"
  scope           = "account"
  encryption_type = "kms"
  #user_id    = each.value.id
  kms_key_name = huaweicloud_kms_key.dew_kms_alias.key_alias
  # lifecycle {
  #   prevent_destroy = true
  # }
}

# resource "huaweicloud_kps_keypair" "kps_keypair" {
#   depends_on      = [huaweicloud_kms_key.dew_kms_alias, huaweicloud_kms_grant.grant_kms]
#   name            = "kps-${var.dew.service_prefix}-${var.dew.environment}"
#   scope           = "account"
#   encryption_type = "kms"
#   kms_key_name    = huaweicloud_kms_key.dew_kms_alias.key_alias

# }