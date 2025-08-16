variable "dns" {
  description = "dns for public internet"
  type = object({
    eps_project_id = string
    environment    = string
    zone_name      = string
    email          = string
    enable_private = bool
    vpc_id         = string
  })
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