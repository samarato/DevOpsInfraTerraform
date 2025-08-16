resource "huaweicloud_obs_bucket" "bucket-infra-state" {
  bucket                = var.obs_state.bucket_name
  region                = var.obs_state.region
  versioning            = true
  enterprise_project_id = "6036b462-c1cd-4638-9d88-35ae5f0a712f" #infra-test
  acl                   = "private"
  tags = {
    environment = "infra-test"
    service     = "obs"
  }
}