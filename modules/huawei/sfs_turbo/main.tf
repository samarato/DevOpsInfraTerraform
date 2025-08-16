resource "huaweicloud_sfs_turbo" "sfs_create" {
  name                  = "${var.prefix}-${var.sfs_turbo.environment}"
  size                  = var.sfs_turbo.size
  share_proto           = "NFS"
  share_type            = "HPC"
  hpc_bandwidth         = var.sfs_turbo.bandwidth #"40M"
  vpc_id                = var.sfs_turbo.vpc_id
  subnet_id             = var.sfs_turbo.subnet_id
  security_group_id     = huaweicloud_networking_secgroup.secgroup_sfs.id
  availability_zone     = var.sfs_turbo.availability_zone
  enterprise_project_id = var.sfs_turbo.eps_project_id

  tags = {
    environment = var.sfs_turbo.environment
    service     = var.sfs_tag_service
  }

  depends_on = [huaweicloud_networking_secgroup.secgroup_sfs]
}