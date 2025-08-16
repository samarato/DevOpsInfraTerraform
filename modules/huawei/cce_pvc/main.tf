resource "huaweicloud_cce_node_pool" "node_pool_create" {
  cluster_id               = var.cce_nodepool.cce_cluster_id
  enterprise_project_id    = var.cce_nodepool.eps_project_id
  name                     = "np-${var.cce_nodepool.node_pool_name}-${var.cce_nodepool.environment}"
  os                       = var.cce_nodepool.instance_os
  initial_node_count       = var.cce_nodepool.initial_node_count
  flavor_id                = var.cce_nodepool.instance_type
  availability_zone        = var.cce_nodepool.availability_zone
  key_pair                 = var.cce_nodepool.key_pair
  scall_enable             = var.cce_nodepool.scall_enable
  min_node_count           = var.cce_nodepool.min_node_count
  max_node_count           = var.cce_nodepool.max_node_count
  scale_down_cooldown_time = var.cce_nodepool.scale_down_cooldown_time
  priority                 = 1
  type                     = "vm"

  root_volume {
    size       = 40
    volumetype = "SAS"
  }
  data_volumes {
    size       = var.cce_nodepool.data_volumes_size
    volumetype = var.cce_nodepool.data_volumes_type #GPSSD2 not support here
    # iops       = 3000 # Check if this is valid for 100GB size
    # throughput = 200  # Ensure this is within allowed limits
  }
}



# resource "huaweicloud_cce_node_pool_nodes_add" "test" {
#   cluster_id  = var.cluster_id
#   nodepool_id = var.nodepool_id

#   node_list {
#     server_id = var.server_id_1
#   }
#   node_list {
#     server_id = var.server_id_2
#   }
# }