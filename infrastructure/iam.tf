module "region1_projects_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.4"

  projects = [module.bank_svc_project.project_id]

  bindings = {
    "roles/compute.networkUser" = [
      local.bank_svc_project_gke_sa,
      local.bank_svc_project_googleapis_sa,
    ]
    "roles/compute.securityAdmin" = [
      local.bank_svc_project_gke_sa,
    ]
    "roles/container.hostServiceAgentUser" = [
      local.bank_svc_project_gke_sa,
    ]
  }
}

module "region2_projects_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 7.4"

  projects = [module.shop_svc_project.project_id]

  bindings = {
    "roles/compute.networkUser" = [
      local.shop_svc_project_gke_sa,
      local.shop_svc_project_googleapis_sa,
    ]
    "roles/compute.securityAdmin" = [
      local.shop_svc_project_gke_sa,
    ]
    "roles/container.hostServiceAgentUser" = [
      local.shop_svc_project_gke_sa,
    ]
  }
}

locals {
  bank_svc_project_gke_sa        = "serviceAccount:service-${module.bank_svc_project.project_number}@container-engine-robot.iam.gserviceaccount.com"
  bank_svc_project_googleapis_sa = "serviceAccount:${module.bank_svc_project.project_number}@cloudservices.gserviceaccount.com"
  shop_svc_project_gke_sa        = "serviceAccount:service-${module.shop_svc_project.project_number}@container-engine-robot.iam.gserviceaccount.com"
  shop_svc_project_googleapis_sa = "serviceAccount:${module.shop_svc_project.project_number}@cloudservices.gserviceaccount.com"
}
