module "host_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 11.3"

  name                           = var.host_project
  random_project_id              = true
  org_id                         = var.org_id
  billing_account                = var.billing_id
  activate_apis                  = var.host_project_apis
  enable_shared_vpc_host_project = true
}

module "bank_svc_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 11.3"

  name                 = var.bank_svc_project
  random_project_id    = true
  org_id               = var.org_id
  billing_account      = var.billing_id
  activate_apis        = var.bank_svc_project_apis
  svpc_host_project_id = module.host_project.project_id
}

module "shop_svc_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 11.3"

  name                 = var.shop_svc_project
  random_project_id    = true
  org_id               = var.org_id
  billing_account      = var.billing_id
  activate_apis        = var.bank_svc_project_apis
  svpc_host_project_id = module.host_project.project_id
}
