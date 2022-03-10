module "region1_projects_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.4"

  projects = [data.terraform_remote_state.foundations.outputs.svc_1_project_id]

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

  projects = [data.terraform_remote_state.foundations.outputs.svc_2_project_id]

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

  projects = [data.terraform_remote_state.foundations.outputs.host_project_id, data.terraform_remote_state.foundations.outputs.svc_1_project_id, data.terraform_remote_state.foundations.outputs.svc_2_project_id]

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
  svc_1_project_gke_sa        = "serviceAccount:service-${data.terraform_remote_state.foundations.outputs.svc_1_project_number}@container-engine-robot.iam.gserviceaccount.com"
  svc_1_project_googleapis_sa = "serviceAccount:${data.terraform_remote_state.foundations.outputs.svc_1_project_number}@cloudservices.gserviceaccount.com"
  svc_2_project_gke_sa        = "serviceAccount:service-${data.terraform_remote_state.foundations.outputs.svc_2_project_number}@container-engine-robot.iam.gserviceaccount.com"
  svc_2_project_googleapis_sa = "serviceAccount:${data.terraform_remote_state.foundations.outputs.svc_2_project_number}@cloudservices.gserviceaccount.com"
  host_project_gkehub_sa      = "serviceAccount:service-${data.terraform_remote_state.foundations.outputs.host_project_number}@gcp-sa-gkehub.iam.gserviceaccount.com"
}

resource "google_project_service_identity" "gkehub_sa" {
  provider = google-beta

  project = data.terraform_remote_state.foundations.outputs.host_project_id
  service = "gkehub.googleapis.com"
}
