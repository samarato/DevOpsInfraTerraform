#Enterprise project we can create but cannot remove
#so we need to manage it carefully or use on web console
#---------------------------------------------------------
# module "eps" {
#   source                             = "../../../../modules/huawei/eps"
#   enterprise_project_name            = var.enterprise_project_name
#   enterprise_project_description     = var.enterprise_project_description
#   cloud_region                       = var.region
#   enterprise_project_create_resource = true
# }


#Create bucket infra for keep terraform.tfstate 
#We need to create onetime for store tfstate
#after created you can comment this block
#---------------------------------------------------------
resource "huaweicloud_obs_bucket" "bucket-infra-state" {
  bucket                = var.obs_state.bucket_name
  region                = var.obs_state.region
  versioning            = true
  enterprise_project_id = local.eps_current_id
  acl                   = "private"
  tags = {
    environment = "infra-test"
    service     = "obs"
  }
}

module "obs" {
  source = "../../modules/huawei/obs"
  obs = {
    bucket_name    = var.obs.bucket_name
    region         = var.region
    endpoint       = var.obs.endpoint
    eps_project_id = local.eps_current_id
    environment    = var.environment
    prefix         = ""

  }
}
#----------------------------------------------
# Start here we can create and remove resources
# Create a VPC
module "vpc" {
  source = "../../modules/huawei/vpc"
  vpc = {
    environment                = var.environment
    eps_project_id             = local.eps_current_id
    cidr                       = var.vpc.cidr
    subnet_public              = var.vpc.subnet_public
    subnet_public_gateway_ip   = var.vpc.subnet_public_gateway_ip
    subnet_database            = var.vpc.subnet_database
    subnet_database_gateway_ip = var.vpc.subnet_database_gateway_ip
    subnet_private             = var.vpc.subnet_private
    subnet_private_gateway_ip  = var.vpc.subnet_private_gateway_ip
  }
}
# Create Elastic Load Balancer
module "elb" {
  source = "../../modules/huawei/elb"
  elb = {
    region             = var.region
    az_name            = var.az_name
    environment        = var.environment
    eps_project_id     = local.eps_current_id
    vpc_id             = module.vpc.output_vpc_current_id
    vpc_ipv4_subnet_id = module.vpc.output_vpc_current_subnet_public_ipv4_id
  }
}
# Create DNS Zone
module "dns_zone" {
  source = "../../modules/huawei/dns_zone"
  dns = {
    environment    = var.environment
    eps_project_id = local.eps_current_id
    zone_name      = var.dns_zone1.zone_name
    email          = var.email
    enable_private = var.dns_zone1.enable_private
    vpc_id         = module.vpc.output_vpc_current_id
  }
}
# Create DNS subdomain for zone1.example.com
module "dns_sub1" {
  depends_on = [module.dns_zone]
  source     = "../../modules/huawei/dns"
  dns = {
    environment     = var.environment
    eps_project_id  = local.eps_current_id
    zone_name       = var.dns_subdomain_zone1.zone_name
    email           = var.email
    enable_private  = var.dns_subdomain_zone1.enable_private
    vpc_id          = module.vpc.output_vpc_current_id
    public_zone_id  = module.dns_zone1.output_dns_zone_public_id
    private_zone_id = module.dns_zone1.output_dns_zone_private_id
  }
  dns_subdomain = var.dns_subdomain_zone1
}

# module "dns_sub2" {
#   source = "../../modules/huawei/dns"
#   dns = {
#     environment    = var.environment
#     eps_project_id = local.eps_current_id
#     domain_name    = var.dns_sub2.domain_name
#     email          = var.email
#     enable_private = var.dns_sub2.enable_private
#     vpc_id         = module.vpc.output_vpc_current_id
#   }
#   dns_subdomain = var.dns_subdomain_sub2
# }

module "eip_nat" {
  source = "../../modules/huawei/eip"
  eip = {
    region         = var.region
    environment    = var.environment
    eps_project_id = local.eps_current_id
  }
}

module "nat_snat" {
  depends_on = [module.eip_nat, module.vpc]
  source     = "../../modules/huawei/nat"
  nat = {
    region             = var.region
    environment        = var.environment
    eps_project_id     = local.eps_current_id
    vpc_id             = module.vpc.output_vpc_current_id
    public_subnet_id   = module.vpc.output_vpc_current_subnet_public_id
    private_subnet_id  = module.vpc.output_vpc_current_subnet_private_id
    database_subnet_id = module.vpc.output_vpc_current_subnet_database_id
    eip_id             = module.eip_nat.output_eip_id
    spec               = "1"
  }
}

# Huawei Software Repository
module "swr" {
  source = "../../modules/huawei/swr"
  swr = {
    region           = var.region
    environment      = var.environment
    eps_project_id   = local.eps_current_id
    branch_name      = var.swr.branch_name
    retention_number = var.swr.retention_number
  }
  swr_user = {
    usernames  = var.swr_user.usernames
    permission = var.swr_user.permission
  }
}

# Create DEW for CCE
module "dew_cce" {
  source = "../../modules/huawei/dew"
  dew = {
    availability_zone = var.az_name
    environment       = var.environment
    eps_project_id    = local.eps_current_id
    region            = var.region
    service_prefix    = var.dew_cce.service_prefix
    usernames         = var.dew_cce.usernames
  }
  dew_csms = {
    name                 = var.dew_csms_cce.name
    secret_key_public    = var.dew_csms_cce.secret_key_public
    secret_value_public  = var.dew_csms_cce.secret_value_public
    secret_key_private   = var.dew_csms_cce.secret_key_private
    secret_value_private = var.dew_csms_cce.secret_value_private
  }
}

module "eip_cce" {
  source = "../../modules/huawei/eip"
  eip = {
    region         = var.region
    environment    = var.environment
    eps_project_id = local.eps_current_id
  }
}
module "cce_turbo" {
  depends_on = [module.vpc, module.eip_cce, module.dew_cce, module.eip_nat, module.nat_snat]
  source     = "../../modules/huawei/cce_turbo"
  cce = {
    environment        = var.environment
    eps_project_id     = local.eps_current_id
    region             = var.region
    availability_zone  = var.az_name
    vpc_id             = module.vpc.output_vpc_current_id
    vpc_subnet_id      = module.vpc.output_vpc_current_subnet_public_id
    vpc_ipv4_subnet_id = module.vpc.output_vpc_current_subnet_private_ipv4_id
    eip_address        = module.eip_cce.output_eip_address
    # instance_os              = var.cce_turbo.instance_os
    # instance_type            = var.cce_turbo.instance_type
    # node_pool_name           = var.cce_turbo.node_pool_name
    # key_pair                 = module.dew_cce.output_kms_current_keypair_name
    # scall_enable             = var.cce_turbo.scall_enable
    # min_node_count           = var.cce_turbo.min_node_count
    # max_node_count           = var.cce_turbo.max_node_count
    # scale_down_cooldown_time = var.cce_turbo.scale_down_cooldown_time
  }
  cce_nat = {
    is_enable_nat_cluster = true
    nat_gateway_id        = module.nat_snat.output_nat_current_id
    eip_id                = module.eip_nat.output_eip_id
    kubeconfig_path       = "${path.root}/.kube/config"
  }
}


# resource "null_resource" "update_kubeconfig" {
#   provisioner "local-exec" {
#     command = <<EOT
#       # How Replace internal IP with public NAT IP in the kubeconfig 
#       sed -i "s/${module.cce_turbo.output_cce_turbo_kube_config_private_ip}:5443/${module.cce_turbo.output_cce_turbo_kube_config_public_ip}:5443/g" .kube/config || echo "Error during sed execution"
#     EOT
#   }
#   triggers = {
#     always_run = timestamp() # This will change with each apply
#   }
#   depends_on = [module.cce_turbo.output_cce_turbo_kube_config]
# }


module "cce_turbo_nodepool" {
  depends_on = [module.cce_turbo]
  source     = "../../modules/huawei/cce_nodepool"
  cce_nodepool = {
    environment       = var.environment
    eps_project_id    = local.eps_current_id
    region            = var.region
    availability_zone = var.az_name
    cce_cluster_id    = module.cce_turbo.output_cce_turbo_cluster_current_id
    instance_os       = var.cce_nodepool.instance_os
    instance_type     = var.cce_nodepool.instance_type
    node_pool_name    = var.cce_nodepool.node_pool_name
    key_pair          = module.dew_cce.output_kms_current_cce_keypair_name

    scall_enable             = var.cce_nodepool.scall_enable
    min_node_count           = var.cce_nodepool.min_node_count
    max_node_count           = var.cce_nodepool.max_node_count
    scale_down_cooldown_time = var.cce_nodepool.scale_down_cooldown_time

    data_volumes_size = var.cce_nodepool.data_volumes_size
    data_volumes_type = var.cce_nodepool.data_volumes_type

    initial_node_count = var.cce_nodepool.initial_node_count
  }
}

module "sfs_turbo" {
  source = "../../modules/huawei/sfs_turbo"
  sfs_turbo = {
    availability_zone = var.az_name
    bandwidth         = var.sfs_turbo.bandwidth
    environment       = var.environment
    eps_project_id    = local.eps_current_id
    size              = var.sfs_turbo.size
    vpc_id            = module.vpc.output_vpc_current_id
    subnet_id         = module.vpc.output_vpc_current_subnet_private_id
    vpc_cidr          = var.vpc.cidr
  }
}