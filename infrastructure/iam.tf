module "region1_projects_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.4"

  projects = [module.bank_svc_project.project_id]

  bindings = {
    "roles/compute.networkUser" = [
      locals.bank_svc_project_gke_sa,
      locals.bank_svc_project_googleapis_sa,
    ]
    "roles/compute.securityAdmin" = [
      locals.bank_svc_project_gke_sa,
    ]
    "roles/container.hostServiceAgentUser" = [
      locals.bank_svc_project_gke_sa,
    ]
  }
}

module "region2_projects_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.4"

  projects = [module.shop_svc_project.project_id]

  bindings = {
    "roles/compute.networkUser" = [
      locals.shop_svc_project_gke_sa,
      locals.shop_svc_project_googleapis_sa,
    ]
    "roles/compute.securityAdmin" = [
      locals.shop_svc_project_gke_sa,
    ]
    "roles/container.hostServiceAgentUser" = [
      locals.shop_svc_project_gke_sa,
    ]
  }
}

locals {
  bank_svc_project_gke_sa        = "serviceAccount:service-${module.bank_svc_project.project_number}@container-engine-robot.iam.gserviceaccount.com"
  bank_svc_project_googleapis_sa = "serviceAccount:${module.bank_svc_project.project_number}@cloudservices.gserviceaccount.com"
  shop_svc_project_gke_sa        = "serviceAccount:service-${module.shop_svc_project.project_number}@container-engine-robot.iam.gserviceaccount.com"
  shop_svc_project_googleapis_sa = "serviceAccount:${module.shop_svc_project.project_number}@cloudservices.gserviceaccount.com"
}
