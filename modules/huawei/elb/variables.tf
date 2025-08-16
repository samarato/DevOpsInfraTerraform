variable "elb" {
  description = "elb for application layer7 included eip"
  type = object({
    region             = string
    environment        = string
    eps_project_id     = string
    vpc_id             = string
    vpc_ipv4_subnet_id = string
    az_name            = string
  })
}

variable "elb_tag_service" {
  description = "elb service tag name"
  type        = string
  default     = "elb"
}
variable "eip_tag_service" {
  description = "eip service tag name"
  type        = string
  default     = "eip"
}

variable "prefix" {
  description = "elb prefix name ex: elb-dedicated-dev => <elb-dedicated> use for prefix"
  type        = string
  default     = "elb-dedicated"
}