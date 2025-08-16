data "huaweicloud_cce_clusters" "clusters" {
  name   = "${var.prefix}-${var.cce_nodepool.environment}"
  status = "Available"
}

data "huaweicloud_compute_flavors" "flavors" {
  availability_zone = var.cce_nodepool.availability_zone
  performance_type  = "normal"
  cpu_core_count    = 2
  memory_size       = 4
}