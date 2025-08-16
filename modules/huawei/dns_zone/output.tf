output "output_dns_private" {
  value = data.huaweicloud_dns_zones.dns_private_zone.zones
}

output "output_dns_public" {
  value = data.huaweicloud_dns_zones.dns_public_zone.zones
}
output "output_dns_zone_public_id" {
  value = huaweicloud_dns_zone.dns_public_create.id
}
output "output_dns_zone_private_id" {
  value = length(huaweicloud_dns_zone.dns_private_create) > 0 ? huaweicloud_dns_zone.dns_private_create[0].id : null
}
