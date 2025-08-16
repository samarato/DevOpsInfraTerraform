data "huaweicloud_elb_loadbalancers" "elb_current" {
  name = "${var.prefix}-${var.elb.environment}"
}

data "huaweicloud_elb_flavors" "flavor_min" {
  type            = "L7"
  max_connections = 200000
  cps             = 2000
  bandwidth       = 50
  region          = var.elb.region
}