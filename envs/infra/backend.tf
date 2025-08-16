#Do not modify or delete it
terraform {
  backend "s3" {
    bucket = "bucket-infra-terraform"
    key    = "infra/infra-test/terraform.tfstate"
    region = "ap-southeast-2" //var.obs_state.region
    endpoints = {
      s3 = "https://obs.ap-southeast-2.myhuaweicloud.com"
    }
    #endpoint = "https://obs.ap-southeast-2.myhuaweicloud.com"
    encrypt                     = true
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
