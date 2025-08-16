output "output_cce_turbo_cluster_current" {
  value = huaweicloud_cce_cluster.cce_create
}

output "output_cce_turbo_cluster_current_id" {
  value = huaweicloud_cce_cluster.cce_create.id
}

output "output_cce_turbo_kube_config" {
  value = local_file.kube_config.filename
}
output "output_cce_turbo_kube_config_private_ip" {
  value = local.cce_private_ip
}
output "output_cce_turbo_kube_config_public_ip" {
  value = local.cce_public_ip
}
# output "output_cce_turbo_nat" {
#   value = huaweicloud_nat_dnat_rule.cce_nat_eip
# }