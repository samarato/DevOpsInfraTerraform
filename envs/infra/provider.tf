terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.68.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }
  }
}


# Configure the Huawei Cloud Stack Provider
provider "huaweicloud" {
  access_key   = var.access_key
  secret_key   = var.secret_key
  region       = var.region
  project_name = var.cloud_provider.project_name
  project_id   = var.cloud_provider.project_id
  cloud        = var.cloud_provider.cloud_domain
  #auth_url     = "https://iam.ap-southeast-2.myhuaweicloud.com/v3"
  # endpoints = {
  #   eps = "https://eps.myhuaweicloud.com"
  # }
}

provider "kubernetes" {
  #config_path = module.cce_turbo.output_cce_turbo_kube_config
  config_path = "${path.root}/.kube/config"
  # config_context = "external"
}