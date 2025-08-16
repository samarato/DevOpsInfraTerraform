
resource "huaweicloud_vpc" "vpc_create" {
  name                  = "${var.prefix}-${var.vpc.environment}"
  cidr                  = var.vpc.cidr
  enterprise_project_id = var.vpc.eps_project_id

  tags = {
    environment = var.vpc.environment
    service     = var.vpc_tag_service
  }

}

resource "huaweicloud_vpc_subnet" "vpc_create_subnet_public" {
  name       = "subnet-public"
  cidr       = var.vpc.subnet_public
  gateway_ip = var.vpc.subnet_public_gateway_ip
  vpc_id     = huaweicloud_vpc.vpc_create.id #data.huaweicloud_vpc.vpc_current.id

  tags = {
    environment = var.vpc.environment
    service     = var.vpc_tag_service
  }
}

resource "huaweicloud_vpc_subnet" "vpc_create_subnet_database" {
  name       = "subnet-database"
  cidr       = var.vpc.subnet_database
  gateway_ip = var.vpc.subnet_database_gateway_ip
  vpc_id     = huaweicloud_vpc.vpc_create.id #data.huaweicloud_vpc.vpc_current.id

  tags = {
    environment = var.vpc.environment
    service     = var.vpc_tag_service
  }
}

resource "huaweicloud_vpc_subnet" "vpc_create_subnet_private" {
  name       = "subnet-private"
  cidr       = var.vpc.subnet_private
  gateway_ip = var.vpc.subnet_private_gateway_ip
  vpc_id     = huaweicloud_vpc.vpc_create.id #data.huaweicloud_vpc.vpc_current.id

  //dns is required for cce node installing
  primary_dns   = "100.125.1.250"
  secondary_dns = "100.125.21.250"

  tags = {
    environment = var.vpc.environment
    service     = var.vpc_tag_service
  }
}
