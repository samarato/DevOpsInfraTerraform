variable "github_organization" {
  type        = string
  description = "github organization name"
  default     = "example"
}
variable "environment" {
  type        = string
  description = "environment name"
}

#region provider config
variable "access_key" {
  description = "Access key for HCS."
  type        = string
}

variable "secret_key" {
  description = "Secret key for HCS."
  type        = string
}

variable "region" {
  description = "region destination for deploy"
  type        = string
}
variable "az_name" {
  type        = string
  description = "availability zone name : ap-southeast-2a,ap-southeast-2b,ap-southeast-2c"
}
variable "email" {
  type        = string
  description = "email address for dns"
}

variable "cloud_provider" {
  description = "Configuration for the cloud provider."
  type = object({
    name         = string
    domain       = string
    project_name = string
    project_id   = string
    cloud_domain = string
  })
}
#end region


#region enterprise project
variable "enterprise_project_name" {
  description = "EPS enterprise project name (required)"
  type        = string
}
variable "enterprise_project_description" {
  description = "EPS enterprise project description (Optional)"
  type        = string
}
#end region

#region module obs_state
variable "obs_state" {
  description = "OBS state bucket for Terraform state"
  type = object({
    bucket_name = string
    endpoint    = string
    prefix      = string
  })
}
#end region

#region module obs_state
variable "obs" {
  description = "OBS bucket for application"
  type = object({
    bucket_name = string
    endpoint    = string
  })
}
#end region

#region module vpc
variable "vpc" {
  description = "vpc valiable"
  type = object({
    cidr                       = string
    subnet_public              = string
    subnet_public_gateway_ip   = string
    subnet_database            = string
    subnet_database_gateway_ip = string
    subnet_private             = string
    subnet_private_gateway_ip  = string
  })
}
#end region

#region module elb
variable "elb" {
  description = "elb valiable"
  type = object({
    # environment     = string
    # eps_project_id  = string
    vpc_id        = string
    vpc_subnet_id = string
    # az_name         = string
  })
}
#end region

#region module dns
variable "dns_zone1" {
  description = "dns for sub1.example.com"
  type = object({
    zone_name      = string
    enable_private = bool
    # public_zone_id  = string
    # private_zone_id = string
  })
}
variable "dns_subdomain_zone1" {
  description = "subdomain for this zone"
  type = map(object({
    subdomain_name  = list(string)
    record_type     = string
    enable_private  = bool
    enable_public   = bool
    public_records  = list(string)
    private_records = list(string)
  }))
}

# variable "dns_zone1" {
#   description = "dns for zone1.example.com"
#   type = object({
#     zone_name      = string
#     enable_private = bool
#   })
# }
# variable "dns_subdomain_zone1" {
#   description = "subdomain for this zone"
#   type = map(object({
#     subdomain_name  = list(string)
#     record_type     = string
#     enable_private  = bool
#     public_records  = list(string)
#     private_records = list(string)
#   }))
# }
#end region

#regiom nat
# variable "nat" {
#   description = "NAT Gateway associate with EIP"
#   type = object({
#     # region           = string
#     # environment      = string
#     # eps_project_id   = string
#     # vpc_id           = string
#     # public_subnet_id = string
#     # spec             = string
#     # eip_id           = string
#   })
# }
#end region

#region swr
variable "swr" {
  description = "software repositories"
  type = object({
    branch_name      = string
    retention_number = number
  })
}
variable "swr_user" {
  description = "users permissions for software repositories"
  type = object({
    usernames  = list(string)
    permission = string
  })
}
#endregion

#region dew
variable "dew_cce" {
  description = "keypair for cce"
  type = object({
    service_prefix = string
    usernames      = list(string)
  })
}
variable "dew_csms_cce" {
  type = object({
    name                 = string
    secret_key_public    = string
    secret_value_public  = string
    secret_key_private   = string
    secret_value_private = string
  })
  default = {
    name                 = ""
    secret_key_public    = ""
    secret_value_public  = ""
    secret_key_private   = ""
    secret_value_private = ""
  }
}

#end region

#region cce_turbo
# variable "cce_turbo" {
#   description = "cce turbo cluster (kubernetes)"
#   type = object({
#     instance_os              = string
#     instance_type            = string
#     node_pool_name           = string
#     scall_enable             = bool
#     min_node_count           = number
#     max_node_count           = number
#     scale_down_cooldown_time = number
#   })
# }
variable "cce_nodepool" {
  description = "cce turbo cluster (kubernetes)"
  type = object({
    instance_os              = string
    instance_type            = string
    node_pool_name           = string
    scall_enable             = bool
    min_node_count           = number
    max_node_count           = number
    scale_down_cooldown_time = number
    data_volumes_size        = number
    data_volumes_type        = string
    initial_node_count       = number
  })
}

variable "cce_nat" {
  description = "CCE Cluster provide public access with NAT port"
  type = object({
    is_enable_nat_cluster = bool
  })
  default = {
    is_enable_nat_cluster = false
  }
}
#end region

#region SFS Turbo
variable "sfs_turbo" {
  description = "SFS Turbo Shared file system turbo"
  type = object({
    bandwidth = string
    size      = number
  })
}
#end region