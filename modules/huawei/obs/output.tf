output "output_obs_current" {
  description = "The OBS bucket created for Terraform state storage"
  value       = huaweicloud_obs_bucket.bucket
}