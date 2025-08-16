resource "huaweicloud_networking_secgroup" "secgroup_sfs" {
  name                  = "seg-sfs-turbo-${var.sfs_turbo.environment}"
  description           = "SFS Turbo security group"
  enterprise_project_id = var.sfs_turbo.eps_project_id

  tags = {
    environment = var.sfs_turbo.environment
    service     = "SecGroup"
  }
}

# Allow NFS traffic from ECS instances or other resources within the same VPC
resource "huaweicloud_networking_secgroup_rule" "allow_nfs_2049" {
  description       = "SFS Turbo security group"
  security_group_id = huaweicloud_networking_secgroup.secgroup_sfs.id
  protocol          = "tcp"
  port_range_min    = 2049
  port_range_max    = 2049
  direction         = "ingress"
  remote_ip_prefix  = var.sfs_turbo.vpc_cidr # Adjust to your VPC CIDR
  ethertype         = "IPv4"
}

resource "huaweicloud_networking_secgroup_rule" "allow_nfs_2051" {
  description       = "SFS Turbo security group"
  security_group_id = huaweicloud_networking_secgroup.secgroup_sfs.id
  protocol          = "tcp"
  port_range_min    = 2051
  port_range_max    = 2051
  direction         = "ingress"
  remote_ip_prefix  = var.sfs_turbo.vpc_cidr # Adjust to your VPC CIDR
  ethertype         = "IPv4"
}

resource "huaweicloud_networking_secgroup_rule" "allow_nfs_2052" {
  description       = "SFS Turbo security group"
  security_group_id = huaweicloud_networking_secgroup.secgroup_sfs.id
  protocol          = "tcp"
  port_range_min    = 2052
  port_range_max    = 2052
  direction         = "ingress"
  remote_ip_prefix  = var.sfs_turbo.vpc_cidr # Adjust to your VPC CIDR
  ethertype         = "IPv4"
}

resource "huaweicloud_networking_secgroup_rule" "allow_mountd_tpc_20048" {
  description       = "SFS Turbo security group"
  security_group_id = huaweicloud_networking_secgroup.secgroup_sfs.id
  protocol          = "tcp"
  port_range_min    = 20048
  port_range_max    = 20048
  direction         = "ingress"
  remote_ip_prefix  = "10.0.0.0/8" # Adjust to your VPC CIDR
  ethertype         = "IPv4"
}

resource "huaweicloud_networking_secgroup_rule" "allow_mountd_udp_20048" {
  description       = "SFS Turbo security group"
  security_group_id = huaweicloud_networking_secgroup.secgroup_sfs.id
  protocol          = "udp"
  port_range_min    = 20048
  port_range_max    = 20048
  direction         = "ingress"
  remote_ip_prefix  = "10.0.0.0/8" # Adjust to your VPC CIDR
  ethertype         = "IPv4"
}

resource "huaweicloud_networking_secgroup_rule" "allow_portmapper_tcp_111" {
  description       = "SFS Turbo security group"
  security_group_id = huaweicloud_networking_secgroup.secgroup_sfs.id
  protocol          = "tcp"
  port_range_min    = 111
  port_range_max    = 111
  direction         = "ingress"
  remote_ip_prefix  = var.sfs_turbo.vpc_cidr # Adjust to your VPC CIDR
  ethertype         = "IPv4"
}

resource "huaweicloud_networking_secgroup_rule" "allow_portmapper_udp_111" {
  description       = "SFS Turbo security group"
  security_group_id = huaweicloud_networking_secgroup.secgroup_sfs.id
  protocol          = "udp"
  port_range_min    = 111
  port_range_max    = 111
  direction         = "ingress"
  remote_ip_prefix  = var.sfs_turbo.vpc_cidr # Adjust to your VPC CIDR
  ethertype         = "IPv4"
}

resource "huaweicloud_networking_secgroup_rule" "allow_statd_662" {
  description       = "SFS Turbo security group"
  security_group_id = huaweicloud_networking_secgroup.secgroup_sfs.id
  protocol          = "tcp"
  port_range_min    = 662
  port_range_max    = 662
  direction         = "ingress"
  remote_ip_prefix  = var.sfs_turbo.vpc_cidr # Adjust to your VPC CIDR
  ethertype         = "IPv4"
}

# If needed, allow outgoing traffic to NFS server
resource "huaweicloud_networking_secgroup_rule" "allow_egress_nfs" {
  description       = "SFS Turbo security group"
  security_group_id = huaweicloud_networking_secgroup.secgroup_sfs.id
  #  protocol          = "-1" # Allow all protocols for outgoing traffic
  direction        = "egress"
  remote_ip_prefix = "0.0.0.0/0"
  ethertype        = "IPv4"
}