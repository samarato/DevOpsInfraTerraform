locals {

  # Check if the last character is a dot
  ends_with_dot = substr(var.dns.zone_name, length(var.dns.zone_name) - 1, 1) == "."

  # Append a dot if it doesn't already end with one
  adjusted_zone_name = local.ends_with_dot ? var.dns.zone_name : "${var.dns.zone_name}."

  public_zone_id  = length(data.huaweicloud_dns_zones.dns_public_zone.zones) > 0 ? data.huaweicloud_dns_zones.dns_public_zone.zones[0].id : ""
  private_zone_id = length(data.huaweicloud_dns_zones.dns_private_zone.zones) > 0 ? data.huaweicloud_dns_zones.dns_private_zone.zones[0].id : ""

}