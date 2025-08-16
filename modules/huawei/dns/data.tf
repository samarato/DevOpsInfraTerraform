data "huaweicloud_dns_zones" "dns_public_zone" {
  zone_type = "public"
  name      = var.dns.zone_name
}

data "huaweicloud_dns_zones" "dns_private_zone" {
  zone_type = "private"
  name      = var.dns.zone_name
}

data "huaweicloud_dns_recordsets" "dns_public_recordsets" {
  zone_id = var.dns.public_zone_id
}


data "huaweicloud_dns_recordsets" "dns_private_recordsets" {
  zone_id = var.dns.private_zone_id
}