resource "huaweicloud_nat_gateway" "nat_create" {
  enterprise_project_id = var.nat.eps_project_id
  name                  = "${var.prefix}-${var.nat.environment}"
  description           = "nat gateway ${var.nat.environment} created by terraform"
  spec                  = var.nat.spec #1,2,3,4
  vpc_id                = var.nat.vpc_id
  subnet_id             = var.nat.public_subnet_id


  tags = {
    environment = var.nat.environment
    service     = var.nat_tag_service
  }
}


resource "huaweicloud_nat_snat_rule" "nat_snat_associate_public" {
  nat_gateway_id = huaweicloud_nat_gateway.nat_create.id
  subnet_id      = var.nat.public_subnet_id
  floating_ip_id = var.nat.eip_id
}

resource "huaweicloud_nat_snat_rule" "nat_snat_associate_private" {
  nat_gateway_id = huaweicloud_nat_gateway.nat_create.id
  subnet_id      = var.nat.private_subnet_id
  floating_ip_id = var.nat.eip_id
}

resource "huaweicloud_nat_snat_rule" "nat_snat_associate_database" {
  nat_gateway_id = huaweicloud_nat_gateway.nat_create.id
  subnet_id      = var.nat.database_subnet_id
  floating_ip_id = var.nat.eip_id
}

# resource "huaweicloud_global_eip_associate" "eip_associate_nat" {
#   depends_on = [huaweicloud_nat_gateway.nat_create, ]

#   global_eip_id  = var.nat.eip_id
#   is_reserve_gcb = false

#   associate_instance {
#     region        = var.nat.region
#     project_id    = data.huaweicloud_identity_projects.identity_project.projects[0].id
#     instance_type = "NATGW" #ECS, PORT, NATGW ,ELB.
#     instance_id   = huaweicloud_nat_gateway.nat_create.id
#   }

#   #   tags = {
#   #     environment = var.nat.environment
#   #     service     = var.eip_tag_service
#   #     associate   = var.nat_tag_service
#   #   }
# }


# resource "huaweicloud_nat_dnat_rule" "newDNATRule_Example" {
#   count = length(var.example_dnat_rule)

#   floating_ip_id = huaweicloud_vpc_eip.newEIP_Example.id
#   nat_gateway_id = huaweicloud_nat_gateway.newNet_gateway_Example.id
#   port_id        = huaweicloud_compute_instance.newCompute_Example.network[0].port

#   internal_service_port = lookup(var.example_dnat_rule[count.index], "internal_service_port", null)
#   protocol              = lookup(var.example_dnat_rule[count.index], "protocol", null)
#   external_service_port = lookup(var.example_dnat_rule[count.index], "external_service_port", null)
# }