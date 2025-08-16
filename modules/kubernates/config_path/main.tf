# provider "kubernetes" {
#   config_path = var.kube.config_path

# }

resource "kubernetes_secret" "my-secret" {
  metadata {
    name      = "my-secret1"
    namespace = var.kube_workload.namespace
  }

  data = {
    "access.key" = "my_access_key"
    "secret.key" = "my_secret_key"
  }

  type = "Opaque"
}

# resource "kubernetes_persistent_volume_claim" "my-pvc" {
#   metadata {
#     name      = "my-pvc-obs"
#     namespace = "default"

#     annotations = {
#       "volume.beta.kubernetes.io/storage-provisioner"    = "everest-csi-provisioner"
#       "everest.io/obs-volume-type"                       = "STANDARD"
#       "csi.storage.k8s.io/fstype"                        = "s3fs"
#       "csi.storage.k8s.io/node-publish-secret-name"      = kubernetes_secret.my-secret.metadata[0].name
#       "csi.storage.k8s.io/node-publish-secret-namespace" = kubernetes_secret.my-secret.metadata[0].namespace
#       "everest.io/enterprise-project-id"                 = "0"
#     }
#   }
#   spec {
#     access_modes = ["ReadWriteMany"]
#     resources {
#       requests = {
#         storage = "1Gi"
#       }
#     }
#     storage_class_name = "csi-obs"
#     volume_name        = kubernetes_persistent_volume.my-pv.metadata.0.name
#   }
# }

# resource "kubernetes_deployment" "my-deployment" {
#   metadata {
#     name      = "web-demo"
#     namespace = "default"
#   }

#   spec {
#     replicas = 2

#     selector {
#       match_labels = {
#         app = "web-demo"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "web-demo"
#         }
#       }

#       spec {
#         container {
#           name  = "container-1"
#           image = "nginx:latest"

#           volume_mount {
#             name       = "pvc-obs-volume"
#             mount_path = "/data"
#           }
#         }
#         image_pull_secrets {
#           name = "default-secret"
#         }
#         volume {
#           name = "pvc-obs-volume"
#           persistent_volume_claim {
#             claim_name = kubernetes_persistent_volume_claim.my-pvc.metadata[0].name
#           }
#         }
#       }
#     }
#   }
# }