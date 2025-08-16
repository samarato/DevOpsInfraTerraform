# output "providerName" {
#   output = ""
# }

# output "access_key" {
#   value = var.access_key
# }

# output "secret_key" {
#   value = var.secret_key
# }


output "current_account_id" {
  value = data.huaweicloud_account.current_account.id
}
output "current_account_name" {
  value = data.huaweicloud_account.current_account.name
}

output "current_enterprise_project_name" {
  value = data.huaweicloud_enterprise_projects.eps_current.name
}

output "current_enterprise_project_id" {
  value = data.huaweicloud_enterprise_projects.eps_current.id
}

output "current_enterprise_projects" {
  value = data.huaweicloud_enterprise_projects.eps_current.enterprise_projects
}
output "current_enterprise_projects_current" {
  value = [
    for project in data.huaweicloud_enterprise_projects.eps_list.enterprise_projects : {
      id     = project.id
      name   = project.name
      status = project.status
    }
  ]
}

output "availability_zones_test" {
  value = data.huaweicloud_availability_zones.az_list
}

# output "module_obs" {
#   value = module.obs
# }

# output "module_vpc" {
#   value = module.vpc
# }

# output "module_elb" {
#   value = module.elb
# }

# output "module_eip_nat" {
#   value = module.eip_nat
# }

# output "module_dns_example" {
#   value = module.dns_example
# }

# output "module_nat_snat" {
#   value = module.nat_snat
# }

# output "module_swr" {
#   value = module.swr
# }
output "module_dew_cce" {
  value = module.dew_cce
}
output "module_eip_cce" {
  value = module.eip_cce
}
output "module_cce_turbo" {
  value = module.cce_turbo
}