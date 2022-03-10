resource "google_project_service" "gke_hub_host_project" {
  project = module.host_project.project_id
  service = "gkehub.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "gke_hub_svc_1_project" {
  project = module.svc_1_project.project_id
  service = "gkehub.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "gke_hub_svc_2_project" {
  project = module.svc_2_project.project_id
  service = "gkehub.googleapis.com"

  disable_on_destroy = false
}
