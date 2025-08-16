variable "obs" {
  description = "OBS bucket for application"
  type = object({
    bucket_name    = string
    region         = string
    endpoint       = string
    prefix         = string
    environment    = string
    eps_project_id = string
  })
}