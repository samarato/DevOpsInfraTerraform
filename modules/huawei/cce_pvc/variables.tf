variable "cce_nodepool" {
  description = "cce node pool you can use 2 scenarios \n 1 use scall_enable = true and use min/max node count \n 2 use scall_enable = false and use add_node_count to manual increase node"
  type = object({
    availability_zone = string
    environment       = string
    eps_project_id    = string
    cce_cluster_id    = string
    cce_namespace     = string
    pvc_name          = string


    data_volumes_size = number
    data_volumes_type = string

    initial_node_count = number
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