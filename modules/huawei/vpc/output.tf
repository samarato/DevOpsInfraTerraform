output "output_vpc_current_id" {
  value = data.huaweicloud_vpc.vpc_current.id
}
output "output_vpc_current_name" {
  value = data.huaweicloud_vpc.vpc_current.name
}

output "output_vpc_current_subnet_private_id" {
  value = huaweicloud_vpc_subnet.vpc_create_subnet_private.id
}
output "output_vpc_current_subnet_private_ipv4_id" {
  value = huaweicloud_vpc_subnet.vpc_create_subnet_private.ipv4_subnet_id
}

output "output_vpc_current_subnet_public_id" {
  value = huaweicloud_vpc_subnet.vpc_create_subnet_public.id
}
output "output_vpc_current_subnet_public_ipv4_id" {
  value = huaweicloud_vpc_subnet.vpc_create_subnet_public.ipv4_subnet_id
}
output "output_vpc_current_subnet_database_id" {
  value = huaweicloud_vpc_subnet.vpc_create_subnet_database.id
}
output "output_vpc_current_subnet_database_ipv4_id" {
  value = huaweicloud_vpc_subnet.vpc_create_subnet_database.ipv4_subnet_id
}
