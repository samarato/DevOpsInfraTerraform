#region Main
github_organization = "example"
environment         = "infra-test"
region              = "ap-southeast-2"
az_name             = "ap-southeast-2c"
email               = "email@example.com"
#end region

#region provider config
cloud_provider = {
  name         = "huaweicloud"
  domain       = "mycloud.com"
  project_name = ""
  project_id   = ""
  cloud_domain = "myhuaweicloud.com"
}
#end region

#region module EPS Enterprise project
enterprise_project_name        = "infra-test"
enterprise_project_description = "This is infra test environment"
#end region

#region module obs_state
obs_state = {
  bucket_name = "bucket-infra-terraform"
  endpoint    = "https://obs.ap-southeast-2.myhuaweicloud.com"
  prefix      = "infra/state/infra"
}
#end region

#region module obs
obs = {
  bucket_name = "bucket-infra"
  endpoint    = "https://obs.ap-southeast-2.myhuaweicloud.com"
}
#end region

#region module vpc
#**Infra:**    `10.60.94.1 - 10.60.94.254` (Total: 254) CIDR 10.60.94.0/24
vpc = {
  cidr                       = "10.60.94.0/24"
  subnet_public              = "10.60.94.0/26"
  subnet_public_gateway_ip   = "10.60.94.1"
  subnet_database            = "10.60.94.64/26"
  subnet_database_gateway_ip = "10.60.94.65"
  subnet_private             = "10.60.94.128/25"
  subnet_private_gateway_ip  = "10.60.94.129"
}
#end region 

#region module elb
elb = {
  vpc_id        = ""
  vpc_subnet_id = ""
}
#end region

#region dns
dns_zone1 = {
  zone_name      = "zone1.example.com"
  enable_private = true
}

dns_subdomain_zone1 = {
  "elb" = {
    subdomain_name  = ["public1", "public2", "public3"]
    record_type     = "CNAME"
    enable_private  = false
    enable_public   = true
    public_records  = ["elb.example.com"]
    private_records = []
  },
  "infra" = {
    subdomain_name  = ["test1", "test2", "test3"]
    record_type     = "CNAME"
    enable_private  = true
    enable_public   = false
    public_records  = ["elb-infra.example.com"]
    private_records = ["private-elb-infra.example.com"]
  }
}

#end region

#region SWR
swr = {
  branch_name      = "develop"
  retention_number = 10
}
swr_user = {
  usernames  = ["user1", "user2"]
  permission = "Manage" #"Manage", "Read", "Write"
}
#end region

#region dew
dew_cce = {
  service_prefix = "cce"
  usernames      = ["itsared"]
}
dew_csms_cce = {
  name                 = "cce"
  secret_key_public    = "public_key"
  secret_value_public  = "/home/user_name/.ssh/id_rsa_huawei.pub"
  secret_key_private   = "private_key"
  secret_value_private = "/home/user_name/.ssh/id_rsa_huawei"
}


#end region

#region cce_turbo
# cce_turbo = {
#   instance_os              = "Ubuntu 22.04"
#   instance_type            = "c7n.large.2"
#   node_pool_name           = "test-01"
#   scall_enable             = false
#   min_node_count           = 0
#   max_node_count           = 50
#   scale_down_cooldown_time = 100
# }
cce_nodepool = {
  instance_os              = "Ubuntu 22.04"
  instance_type            = "c7n.large.2"
  node_pool_name           = "test-01"
  scall_enable             = false
  min_node_count           = 0
  max_node_count           = 50
  scale_down_cooldown_time = 100
  data_volumes_size        = 100
  data_volumes_type        = "SSD"
  initial_node_count       = 1
}

cce_nat = {
  is_enable_nat_cluster = true
}
#end region

#region SFS Turbo
sfs_turbo = {
  bandwidth = "40M"
  size      = 3686
}
#end region