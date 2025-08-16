variable "cce" {
  description = "CCE Turbo Cluster creation"
  type = object({
    region             = string
    availability_zone  = string
    environment        = string
    eps_project_id     = string
    vpc_id             = string
    vpc_subnet_id      = string
    vpc_ipv4_subnet_id = string
    eip_address        = string
  })

}
variable "cce_nat" {
  description = "CCE Cluster provide public access with NAT port"
  type = object({
    is_enable_nat_cluster = bool
    nat_gateway_id        = string
    eip_id                = string
    kubeconfig_path       = string
  })
  default = {
    is_enable_nat_cluster = false
    nat_gateway_id        = ""
    eip_id                = ""
    kubeconfig_path       = ""
  }
}

# variable "swr_user" {
#   description = "software repository org permissions"
#   type = object({
#     usernames  = list(string)
#     permission = string #Manage, Read, Write
#   })
# }


variable "cce_tag_service" {
  description = "cce service tag name"
  type        = string
  default     = "cce"
}

variable "prefix" {
  description = "cce prefix name ex: cce-dev => <cce> use for prefix"
  type        = string
  default     = "cce"
}