variable "swr" {
  description = "software repository"
  type = object({
    region           = string
    environment      = string
    eps_project_id   = string
    branch_name      = string
    retention_number = number
  })
}

variable "swr_user" {
  description = "software repository org permissions"
  type = object({
    usernames  = list(string)
    permission = string #Manage, Read, Write
  })
}