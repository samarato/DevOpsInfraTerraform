variable "sfs_turbo" {
  description = "sfs turbo Shared file system turbo"
  type = object({
    availability_zone = string
    environment       = string
    eps_project_id    = string
    vpc_id            = string
    vpc_cidr          = string
    bandwidth         = string
    subnet_id         = string
    size              = number

  })
}


variable "sfs_tag_service" {
  description = "sfs service tag name"
  type        = string
  default     = "sfs"
}

variable "prefix" {
  description = "sfs prefix name ex: sfs-dev => <sfs> use for prefix"
  type        = string
  default     = "sfs"
}