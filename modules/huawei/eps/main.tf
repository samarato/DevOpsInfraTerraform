# provider "huaweicloud" {
#   region = var.cloud_region
#   # Other provider-specific configurations
# }


# resource "huaweicloud_enterprise_project" "eps_current" {
#   count = var.enterprise_project_create_resource ? 1 : 0

#   name        = "eps_${var.enterprise_project_name}"
#   description = var.enterprise_project_description
#   enable      = true

# }

resource "huaweicloud_enterprise_project_authority" "eps_current" {}

