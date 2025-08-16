data "huaweicloud_dns_zones" "dns_public_zone" {
  zone_type = "public"
  # enterprise_project_id = var.dns.eps_project_id
  name = var.dns.zone_name
}

data "huaweicloud_dns_zones" "dns_private_zone" {
  zone_type = "private"
  # enterprise_project_id = var.dns.eps_project_id
  name = var.dns.zone_name
}
