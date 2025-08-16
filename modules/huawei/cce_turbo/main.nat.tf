data "huaweicloud_networking_port" "port_1" {
  fixed_ip = local.cce_private_ip
}
resource "huaweicloud_nat_dnat_rule" "cce_nat_eip" {
  # count = var.cce_nat.eip_id != "" ? 1 : 0

  nat_gateway_id        = var.cce_nat.nat_gateway_id
  floating_ip_id        = var.cce_nat.eip_id
  port_id               = data.huaweicloud_networking_port.port_1.port_id
  protocol              = "tcp"
  internal_service_port = 5443
  external_service_port = 5443
  depends_on            = [data.huaweicloud_networking_port.port_1]
}
