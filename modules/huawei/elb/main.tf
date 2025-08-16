
resource "huaweicloud_vpc_eip" "eip_for_elb" {
  enterprise_project_id = var.elb.eps_project_id
  region                = var.elb.region
  name                  = "${var.prefix}-${var.elb.environment}"
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "bandwidth-${var.elb.environment}"
    size        = 300
    share_type  = "PER"
    charge_mode = "traffic"
  }
  tags = {
    environment = var.elb.environment
    service     = var.eip_tag_service
  }
}

resource "huaweicloud_elb_loadbalancer" "elb_create" {
  region                = var.elb.region
  enterprise_project_id = var.elb.eps_project_id
  name                  = "${var.prefix}-${var.elb.environment}"
  description           = "ELB ${var.elb.environment} Created by terraform"

  vpc_id         = var.elb.vpc_id
  ipv4_subnet_id = var.elb.vpc_ipv4_subnet_id
  # ipv6_network_id = huaweicloud_vpc_subnet.default.id
  l7_flavor_id = data.huaweicloud_elb_flavors.flavor_min.flavors[0].id
  availability_zone = [
    # data.huaweicloud_availability_zones.default.names[2]
    var.elb.az_name
  ]
  tags = {
    environment = var.elb.environment
    service     = var.elb_tag_service
  }

  ipv4_eip_id = huaweicloud_vpc_eip.eip_for_elb.id
  # iptype                = "5_bgp"
  # bandwidth_charge_mode = "traffic"
  # sharetype             = "PER"
  # bandwidth_size        = 300

}

# # associate eip with loadbalancer
# resource "huaweicloud_vpc_eip_associate" "elb_associate_eip" {
#   public_ip = huaweicloud_vpc_eip.eip_for_elb.address
#   port_id   = huaweicloud_elb_loadbalancer.elb_create.ipv4_port_id
# }