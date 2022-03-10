module "host_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 11.3"

  name                           = var.host_project
  random_project_id              = true
  org_id                         = var.org_id
  billing_account                = var.billing_id
  activate_apis                  = var.host_project_apis
  enable_shared_vpc_host_project = true
  folder_id                      = module.main_folder.id
}

module "svc_1_project" {
  source  = "terraform-google-modules/project-factory/google//modules/svpc_service_project"
  version = "~> 11.3"

  name              = var.bank_svc_project
  random_project_id = true
  org_id            = var.org_id
  billing_account   = var.billing_id
  activate_apis     = var.bank_svc_project_apis
  shared_vpc        = module.host_project.project_id
  folder_id         = module.main_folder.id
  shared_vpc_subnets = [
    format("projects/%s/regions/%s/subnetworks/%s", module.host_project.project_id, var.region1, "subnet-01")
  ]
  depends_on = [
    module.host_project,
    module.vpc,
  ]
}

module "svc_2_project" {
  source  = "terraform-google-modules/project-factory/google//modules/svpc_service_project"
  version = "~> 11.3"

  name              = var.shop_svc_project
  random_project_id = true
  org_id            = var.org_id
  billing_account   = var.billing_id
  activate_apis     = var.bank_svc_project_apis
  shared_vpc        = module.host_project.project_id
  folder_id         = module.main_folder.id
  shared_vpc_subnets = [
    format("projects/%s/regions/%s/subnetworks/%s", module.host_project.project_id, var.region2, "subnet-02")
  ]
  depends_on = [
    module.host_project,
    module.vpc,
  ]
}
