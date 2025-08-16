locals {
  valid_dns_subdomains = [
    for dns in var.dns_subdomain : dns
    if data.huaweicloud_dns_zones.dns_public_zone.zones != null
  ]

  all_subdomains = [
    for sub in var.dns_subdomain : [
      for subdomain in sub.subdomain_name : {
        name            = "${subdomain}.${var.dns.environment}.${var.dns.zone_name}"
        record_type     = sub.record_type
        public_records  = sub.public_records
        enable_private  = sub.enable_private
        enable_public   = sub.enable_public
        private_records = sub.private_records
      }
    ]
  ]

  # Flatten the nested lists
  flattened_subdomains = flatten(local.all_subdomains)


}