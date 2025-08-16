data "huaweicloud_account" "current_account" {}

data "huaweicloud_enterprise_projects" "eps_current" {
  name = var.enterprise_project_name
}
data "huaweicloud_enterprise_projects" "eps_list" {
}

data "huaweicloud_availability_zones" "az_list" {}