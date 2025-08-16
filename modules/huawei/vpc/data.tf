data "huaweicloud_vpc" "vpc_current" {
  name = huaweicloud_vpc.vpc_create.name #VPC Name
}