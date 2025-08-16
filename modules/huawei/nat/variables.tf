variable "nat" {
  description = "NAT Gateway associate with EIP"
  type = object({
    region             = string
    environment        = string
    eps_project_id     = string
    vpc_id             = string
    public_subnet_id   = string
    private_subnet_id  = string
    database_subnet_id = string
    spec               = string
    eip_id             = string
  })
}

variable "nat_tag_service" {
  description = "nat service tag name"
  type        = string
  default     = "nat"
}
variable "eip_tag_service" {
  description = "eip service tag name"
  type        = string
  default     = "eip"
}

variable "prefix" {
  description = "nat prefix name ex: nat-dev => <nat> use for prefix"
  type        = string
  default     = "nat"
}