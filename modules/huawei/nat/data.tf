# data "huaweicloud_nat_gateway" "nat_current" {
#   name = "${var.prefix}-${var.nat.environment}"
# }

data "huaweicloud_identity_projects" "identity_project" {
  name = var.nat.region
}