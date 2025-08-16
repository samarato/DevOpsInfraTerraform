variable "enterprise_project_name" {
  description = "EPS enterprise project name (required)"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.enterprise_project_name) > 0
    error_message = "The enterprise project name must not be empty."
  }

}

variable "enterprise_project_description" {
  description = "EPS enterprise project description"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.enterprise_project_description) > 0
    error_message = "The enterprise project description must not be empty."
  }
}

variable "enterprise_project_create_resource" {
  description = "this is flag mark for use eps infra test environment"
  type        = bool
  default     = false
}
variable "cloud_region" {
  description = "Region name for HCS."
  type        = string
}