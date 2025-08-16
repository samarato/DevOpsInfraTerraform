#Key Points
# Node Creation: The huaweicloud_cce_node resource creates nodes directly, 
#     but these nodes are not managed as part of a node pool. Instead, 
#     they are standalone nodes within the cluster.
# Node Pools: If you want to manage nodes as part of a node pool, 
#     you'll need to create the node pool using the huaweicloud_cce_nodepool 
#     resource and then attach existing instances (servers) using huaweicloud_cce_node_attach.


# resource "huaweicloud_cce_node" "node_crate" {
#   cluster_id        = var.cce_node.cluster_id
#   name              = "cce-node-${var.cce_node.node_name}-${var.cce_node.environment}"
#   os                = var.cce_nodepool.instance_os
#   flavor_id         = var.cce_nodepool.instance_type
#   availability_zone = var.cce_nodepool.availability_zone
#   key_pair          = var.cce_nodepool.key_pair #var.keypair

#   root_volume {
#     size       = 40
#     volumetype = "SAS"
#   }
#   data_volumes {
#     size       = 100
#     volumetype = "SSD" #GPSSD2 not support here
#     # iops       = 3000 # Check if this is valid for 100GB size
#     # throughput = 200  # Ensure this is within allowed limits
#   }
# }

# resource "huaweicloud_cce_node_attach" "node_attach" {
#   cluster_id = var.cce_node.cluster_id
#   server_id  = huaweicloud_compute_instance.myecs.id
#   key_pair   = huaweicloud_compute_keypair.mykeypair.name
#   os         = var.os
# }