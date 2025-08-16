variable "dns" {
  description = "dns for public internet"
  type = object({
    eps_project_id  = string
    environment     = string
    zone_name       = string
    email           = string
    enable_private  = bool
    vpc_id          = string
    public_zone_id  = string
    private_zone_id = string
  })
}
variable "dns_subdomain" {
  description = "subdomain for this zone"
  type = map(object({
    subdomain_name  = list(string)
    record_type     = string #A, AAAA, MX, CNAME, TXT, NS, SRV, CAA.
    enable_private  = bool
    enable_public   = bool
    public_records  = list(string)
    private_records = list(string)
  }))
  validation {
    condition     = alltrue([for s in var.dns_subdomain : contains(["A", "AAAA", "MX", "CNAME", "TXT", "NS", "SRV", "CAA"], s.record_type)])
    error_message = "record_type must be one of A, AAAA, MX, CNAME, TXT, NS, SRV, or CAA."
  }
}

variable "dns_tag_service" {
  description = "dns service tag name"
  type        = string
  default     = "dns"
}

variable "prefix" {
  description = "dns prefix name ex: eip-dev => <eip> use for prefix"
  type        = string
  default     = "dns"
}