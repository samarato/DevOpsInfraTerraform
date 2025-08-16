variable "eip" {
  description = "eip for public internet"
  type = object({
    region         = string
    environment    = string
    eps_project_id = string
  })
}


variable "eip_tag_service" {
  description = "eip service tag name"
  type        = string
  default     = "eip"
}

variable "prefix" {
  description = "eip prefix name ex: eip-dev => <eip> use for prefix"
  type        = string
  default     = "eip"
}