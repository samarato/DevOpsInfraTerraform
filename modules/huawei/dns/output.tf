output "output_dns_private" {
  value = data.huaweicloud_dns_zones.dns_private_zone.zones
}

output "output_dns_public" {
  value = data.huaweicloud_dns_zones.dns_public_zone.zones
}

output "output_dns_public_records" {
  value = data.huaweicloud_dns_recordsets.dns_public_recordsets
}

output "output_dns_private_records" {
  value = data.huaweicloud_dns_recordsets.dns_private_recordsets
}