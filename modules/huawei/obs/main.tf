resource "huaweicloud_obs_bucket" "bucket" {
  bucket                = var.obs.bucket_name
  region                = var.obs.region
  versioning            = false
  storage_class         = "STANDARD"
  multi_az              = true
  enterprise_project_id = var.obs.eps_project_id
  acl                   = "private"
  tags = {
    environment = var.obs.environment
    service     = "obs"
  }
}