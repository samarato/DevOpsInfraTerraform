variable "dew" {
  description = "software repository"
  type = object({
    region            = string
    availability_zone = string
    environment       = string
    eps_project_id    = string
    service_prefix    = string
    usernames         = list(string)
  })
}

variable "dew_csms" {
  type = object({
    name                 = string
    secret_key_public    = string
    secret_value_public  = string
    secret_key_private   = string
    secret_value_private = string
  })
  default = {
    name                 = ""
    secret_key_public    = ""
    secret_value_public  = ""
    secret_key_private   = ""
    secret_value_private = ""
  }
}

variable "dew_tag_service" {
  description = "dew service tag name"
  type        = string
  default     = "dew"
}

variable "prefix" {
  description = "dew prefix name ex: dew-dev => <dew> use for prefix"
  type        = string
  default     = "dew"
}