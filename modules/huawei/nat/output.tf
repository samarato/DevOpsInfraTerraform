# output "output_nat_current" {
#   value = data.huaweicloud_nat_gateway.nat_current
# }
output "output_nat_current" {
  value = huaweicloud_nat_gateway.nat_create
}
output "output_identity_project" {
  value = data.huaweicloud_identity_projects.identity_project.projects[0]
}

output "output_nat_current_id" {
  value = huaweicloud_nat_gateway.nat_create.id
}