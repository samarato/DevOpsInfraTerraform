# Workload for CCE
module "wl_example" {
  source = "../../modules/kubernates/config_path"
  kube = {
    config_path    = "${path.root}/.kube/config"
    environment    = var.environment
    eps_project_id = local.eps_current_id
    vpc_id         = module.vpc.output_vpc_current_id
    cce_cluster_id = module.cce_turbo.output_cce_turbo_cluster_current_id
  }
  kube_workload = {
    container_name = var.kube_workload.container_name
    namespace      = var.kube_workload.namespace
    number_pods    = var.kube_workload.number_pods
    service_port   = var.kube_workload.service_port
    service_type   = var.kube_workload.service_type
    workload_name  = var.kube_workload.workload_name
    workload_type  = var.kube_workload.workload_type

  }
  providers = {
    kubernetes = kubernetes
  }
}