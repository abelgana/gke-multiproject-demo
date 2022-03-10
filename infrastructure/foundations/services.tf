# resource "google_project_service" "gke_hub_host_project" {
#   count = length(var.host_project_apis)

#   project = module.host_project.project_id
#   service = var.host_project_apis[count.index]

#   disable_on_destroy = false
# }

# resource "google_project_service" "gke_hub_svc_1_project" {
#   count = length(var.svc_1_project_apis)

#   project            = module.svc_1_project.project_id
#   service            = var.svc_1_project_apis[count.index]
#   disable_on_destroy = false
# }

# resource "google_project_service" "gke_hub_svc_2_project" {
#   count = length(var.svc_2_project_apis)

#   project = module.svc_2_project.project_id
#   service = var.svc_2_project_apis[count.index]

#   disable_on_destroy = false
# }
