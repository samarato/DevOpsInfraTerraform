resource "huaweicloud_dns_recordset" "public_subdomain" {
  # for_each = {
  #   for dns in local.valid_dns_subdomains :
  #   dns.subdomain_name => dns
  # }
  for_each = {
    for idx, subdomain in local.flattened_subdomains :
    "${subdomain.name}-${idx}" => subdomain
    if subdomain.enable_public
  }
  zone_id = length(data.huaweicloud_dns_zones.dns_public_zone.zones) > 0 ? data.huaweicloud_dns_zones.dns_public_zone.zones[0].id : ""
  name    = substr(each.value.name, length(each.value.name) - 1, 1) == "." ? each.value.name : "${each.value.name}."
  type    = each.value.record_type

  description = "a recordset description"
  status      = "ENABLE"
  ttl         = 300
  #records     = length(each.value.public_records) > 0 ? ["${each.value.public_records}."] : [""]
  records = length(each.value.public_records) > 0 ? [
    for record in each.value.public_records :
    substr(record, length(record) - 1, 1) == "." ? record : "${record}."
  ] : [""]
  #line_id     = "Dianxin_Shanxi"
  weight = 10

  tags = {
    environment = var.dns.environment
    service     = var.dns_tag_service
  }
}

resource "huaweicloud_dns_recordset" "private_subdomain" {
  for_each = {
    for idx, subdomain in local.flattened_subdomains :
    "${subdomain.name}-${idx}" => subdomain
    if subdomain.enable_private
  }
  zone_id = length(data.huaweicloud_dns_zones.dns_private_zone.zones) > 0 ? data.huaweicloud_dns_zones.dns_private_zone.zones[0].id : ""

  name = substr(each.value.name, length(each.value.name) - 1, 1) == "." ? each.value.name : "${each.value.name}."
  type = each.value.record_type

  description = "a recordset description"
  status      = "ENABLE"
  ttl         = 300
  #records     = length(each.value.private_records) > 0 ? each.value.private_records : [""]
  records = length(each.value.private_records) > 0 ? [
    for record in each.value.private_records :
    substr(record, length(record) - 1, 1) == "." ? record : "${record}."
  ] : [""]
  #line_id     = "Dianxin_Shanxi"  

  tags = {
    environment = var.dns.environment
    service     = var.dns_tag_service
  }

}