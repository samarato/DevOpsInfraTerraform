variable "obs_state" {
  description = "OBS state bucket for Terraform state"
  type = object({
    bucket_name = string
    region      = string
    endpoint    = string
    prefix      = string
  })
}