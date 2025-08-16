resource "huaweicloud_vpc_eip" "eip_create" {
  enterprise_project_id = var.eip.eps_project_id
  region                = var.eip.region
  name                  = "${var.prefix}-${var.eip.environment}"
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "bandwidth-${var.eip.environment}"
    size        = 300
    share_type  = "PER"
    charge_mode = "traffic"
  }
  tags = {
    environment = var.eip.environment
    service     = var.eip_tag_service
  }
}