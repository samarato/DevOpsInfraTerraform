variable "vpc" {
  description = "VPC for application"
  type = object({
    cidr                       = string
    environment                = string
    eps_project_id             = string
    subnet_public              = string
    subnet_public_gateway_ip   = string
    subnet_database            = string
    subnet_database_gateway_ip = string
    subnet_private             = string
    subnet_private_gateway_ip  = string
  })
}

variable "vpc_tag_service" {
  description = "vpc service tag name"
  type        = string
  default     = "vpc"
}

variable "prefix" {
  description = "vpc prefix name ex: vpc-dev => <vpc> use for prefix"
  type        = string
  default     = "vpc"
}