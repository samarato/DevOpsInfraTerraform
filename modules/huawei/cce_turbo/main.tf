# resource "huaweicloud_vpc_subnet" "eni_test_1" {
#   name       = "subnet-eni-1"
#   cidr       = "192.168.2.0/24"
#   gateway_ip = "192.168.2.1"
#   vpc_id     = huaweicloud_vpc.test.id
# }

resource "huaweicloud_cce_cluster" "cce_create" {
  name                   = "${var.prefix}-${var.cce.environment}"
  enterprise_project_id  = var.cce.eps_project_id
  flavor_id              = "cce.s1.small"
  vpc_id                 = var.cce.vpc_id
  subnet_id              = var.cce.vpc_subnet_id
  container_network_type = "eni"
  eip                    = length(var.cce.eip_address) > 0 ? var.cce.eip_address : null

  eni_subnet_id = join(",", [
    var.cce.vpc_ipv4_subnet_id
  ])

  masters {
    availability_zone = var.cce.availability_zone
  }
  #https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/examples/cce/basic/cce-cluster-enhanced-authentication.md
  # authentication_mode              = "authenticating_proxy"
  # authenticating_proxy_ca          = filebase64("your_directory/ca.crt")
  # authenticating_proxy_cert        = filebase64("your_directory/client.crt")
  # authenticating_proxy_private_key = filebase64("your_directory/client.key")

  tags = {
    environment = var.cce.environment
    service     = var.cce_tag_service
  }
}

resource "huaweicloud_cce_namespace" "cce_namespace_create" {
  cluster_id = huaweicloud_cce_cluster.cce_create.id
  name       = "ns-${var.cce.environment}"
}

resource "local_file" "kube_config" {
  content  = huaweicloud_cce_cluster.cce_create.kube_config_raw
  filename = var.cce_nat.kubeconfig_path
}


#local.cce_private_ip, huaweicloud_nat_dnat_rule.cce_nat_eip.floating_ip_id
# Use local-exec to replace internal IP with public NAT IP in kubeconfig
# data "template_file" "kubeconfig" {
#   template = file("${path.module}/kubeconfig.tpl")

#   vars = {
#     public_ip = huaweicloud_nat_dnat_rule.cce_nat_eip.floating_ip_id
#   }
# }

# output "kubeconfig" {
#   value = data.template_file.kubeconfig.rendered
# }

# # Read the original file
# data "local_file" "original_config" {
#   #filename = "${path.module}/config.txt"
#   filename = ".kube/config.txt"
# }

# # Replace the old IP with the new one
# locals {
#   updated_content = replace(data.local_file.original_config.content, local.cce_private_ip, huaweicloud_nat_dnat_rule.cce_nat_eip.floating_ip_id)
# }

# # Write the updated content to a new file
# resource "local_file" "updated_config" {
#   content = local.updated_content
#   #filename = "${path.module}/config.txt"
#   filename = ".kube/config.txt"
# }


# resource "huaweicloud_cce_cluster_log_config" "cce_create_log" {
#   cluster_id  = huaweicloud_cce_cluster.cce_create.id
#   ttl_in_days = 30
#   log_configs {
#     name   = "kube-apiserver-${var.cce.environment}"
#     enable = true
#   }

#   log_configs {
#     name   = "kube-controller-manager-${var.cce.environment}"
#     enable = true
#   }

#   log_configs {
#     name   = "kube-scheduler-${var.cce.environment}"
#     enable = false
#   }

#   log_configs {
#     name   = "audit-${var.cce.environment}"
#     enable = true
#   }
# }