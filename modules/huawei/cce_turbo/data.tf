# data "huaweicloud_swr_organizations" "swr_current" {
#   name = var.swr.environment
# }

# data "huaweicloud_swr_repositories" "swr_current_repo" {
#   region       = var.swr.region
#   organization = var.swr.environment
# }

# data "huaweicloud_identity_users" "identity_users" {
#   for_each = toset(var.swr_user.usernames) # Convert the list to a set for uniqueness

#   name = each.key # Each username in the list  
# }

data "huaweicloud_cce_clusters" "clusters" {
  name   = "${var.prefix}-${var.cce.environment}"
  status = "Available"
}

data "huaweicloud_compute_flavors" "flavors" {
  availability_zone = var.cce.availability_zone
  performance_type  = "normal"
  cpu_core_count    = 2
  memory_size       = 4
}
# Create ECS instance with the first matched flavor
# resource "huaweicloud_compute_instance" "instance" {
#   flavor_id = data.huaweicloud_compute_flavors.flavors.ids[0]

#   # Other properties...
# }