output "output_sfs_turbo" {
  value = huaweicloud_sfs_turbo.sfs_create
}

output "output_sfs_turbo_current_id" {
  value = huaweicloud_sfs_turbo.sfs_create.id
}

output "output_sfs_turbo_security_group_id" {
  value = huaweicloud_networking_secgroup.secgroup_sfs.id
}