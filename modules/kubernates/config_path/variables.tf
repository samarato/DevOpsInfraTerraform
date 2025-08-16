variable "kube" {
  description = "kubernates config"
  type = object({
    eps_project_id = string
    environment    = string
    vpc_id         = string
    config_path    = string
    cce_cluster_id = string
  })
}

variable "kube_workload" {
  description = "workload config"
  type = object({
    workload_name = string
    workload_type = string #deployment, statefulset

    namespace   = string
    number_pods = number


    container_name = list(string)



    service_port = number
    service_type = string
  })
}