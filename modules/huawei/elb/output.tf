output "output_elb_current_id" {
  value = length(data.huaweicloud_elb_loadbalancers.elb_current.loadbalancers) > 0 ? data.huaweicloud_elb_loadbalancers.elb_current.loadbalancers[0].id : null
}

output "output_elb_current" {
  value = data.huaweicloud_elb_loadbalancers.elb_current
}

output "elb_flavors_l7_min_id" {
  value = data.huaweicloud_elb_flavors.flavor_min.flavors[0].id
}

output "elb_flavors_l7_list" {
  value = data.huaweicloud_elb_flavors.flavor_min
}