module "region1_projects_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.4"

  projects = [module.svc_1_project.project_id]

  bindings = {
    "roles/compute.networkUser" = [
      local.svc_1_project_gke_sa,
      local.svc_1_project_googleapis_sa,
    ]
    "roles/compute.securityAdmin" = [
      local.svc_1_project_gke_sa,
    ]
    "roles/container.hostServiceAgentUser" = [
      local.svc_1_project_gke_sa,
    ]
  }
}

module "region2_projects_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.4"

  projects = [module.svc_2_project.project_id]

  bindings = {
    "roles/compute.networkUser" = [
      local.svc_2_project_gke_sa,
      local.svc_2_project_googleapis_sa,
    ]
    "roles/compute.securityAdmin" = [
      local.svc_2_project_gke_sa,
    ]
    "roles/container.hostServiceAgentUser" = [
      local.svc_2_project_gke_sa,
    ]
  }
}

module "gkehub_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.4"

  projects = [module.host_project.project_id, module.svc_1_project.project_id, module.svc_2_project.project_id]

  bindings = {
    "roles/gkehub.serviceAgent" = [
      local.host_project_gkehub_sa,
    ]
  }
  depends_on = [
    google_project_service_identity.gkehub_sa,
  ]
}

locals {
  svc_1_project_gke_sa        = "serviceAccount:service-${module.svc_1_project.project_number}@container-engine-robot.iam.gserviceaccount.com"
  svc_1_project_googleapis_sa = "serviceAccount:${module.svc_1_project.project_number}@cloudservices.gserviceaccount.com"
  svc_2_project_gke_sa        = "serviceAccount:service-${module.svc_2_project.project_number}@container-engine-robot.iam.gserviceaccount.com"
  svc_2_project_googleapis_sa = "serviceAccount:${module.svc_2_project.project_number}@cloudservices.gserviceaccount.com"
  host_project_gkehub_sa      = "serviceAccount:service-${module.host_project.project_number}@gcp-sa-gkehub.iam.gserviceaccount.com"
}

resource "google_project_service_identity" "gkehub_sa" {
  provider = google-beta

  project = module.host_project.project_id
  service = "gkehub.googleapis.com"
}
