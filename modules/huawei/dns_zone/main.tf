resource "huaweicloud_dns_zone" "dns_public_create" {
  enterprise_project_id = var.dns.eps_project_id
  name                  = local.adjusted_zone_name #var.dns.zone_name
  email                 = var.dns.email
  description           = "public zone ${var.dns.zone_name}"
  ttl                   = 300
  zone_type             = "public"
  tags = {
    environment = var.dns.environment
    service     = var.dns_tag_service
  }
}

resource "huaweicloud_dns_zone" "dns_private_create" {
  count = var.dns.enable_private ? 1 : 0

  enterprise_project_id = var.dns.eps_project_id
  name                  = local.adjusted_zone_name
  email                 = var.dns.email
  description           = "private zone ${var.dns.zone_name}"
  ttl                   = 300
  zone_type             = "private"
  router {
    router_id = var.dns.vpc_id
  }

  tags = {
    environment = var.dns.environment
    service     = var.dns_tag_service
  }
}