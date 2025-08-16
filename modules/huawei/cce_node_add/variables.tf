variable "cce_nodepool" {
  description = "value"
  type = object({
    region                   = string
    availability_zone        = string
    environment              = string
    eps_project_id           = string
    cce_cluster_id           = string
    instance_type            = string #list(string)
    instance_os              = string
    node_pool_name           = string
    scall_enable             = bool
    min_node_count           = number
    max_node_count           = number
    scale_down_cooldown_time = number
  })
}


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