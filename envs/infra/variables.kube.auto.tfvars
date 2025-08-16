kube_workload = {
  workload_name  = "test"
  workload_type  = "deployment" #deployment, statefulset
  namespace      = "ns-infra-test"
  number_pods    = 1
  container_name = ["", ""]
  service_port   = 5000
  service_type   = "clusterIP"
}