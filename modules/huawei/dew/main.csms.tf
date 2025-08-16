# resource "huaweicloud_csms_secret" "csms_create" {
#   count = length(var.dew_csms.secret_key) > 0 ? 1 : 0

#   name = "csms-${var.dew_csms.name}-${var.dew.environment}"
#   secret_text = jsonencode({
#     (var.dew_csms.secret_key) = fileexists(var.dew_csms.secret_value) ? file(var.dew_csms.secret_value) : var.dew_csms.secret_value
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