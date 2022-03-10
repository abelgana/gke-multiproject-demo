module "asm_region1a" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/asm"

  asm_version      = "1.10"
  location         = module.gke_region1a_prod.location
  cluster_endpoint = module.gke_region1a_prod.endpoint
  cluster_name     = module.gke_region1a_prod.name
  # enable_all            = true
  # managed_control_plane = true
  enable_all = false
  # enable_cluster_roles  = true
  enable_cluster_labels     = true
  enable_namespace_creation = true
  # enable_gcp_apis       = false
  # enable_gcp_iam_roles = false
  enable_gcp_components = true
  enable_registration   = false
  # managed_control_plane = false
  mode            = "install"
  project_id      = data.terraform_remote_state.foundations.outputs.svc_1_project_id
  revision_name   = "asm-1-10"
  custom_overlays = ["./asm_config/multiproject1.yaml"]
}

module "asm_region2a" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/asm"

  asm_version      = "1.10"
  location         = module.gke_region2a_prod.location
  cluster_endpoint = module.gke_region2a_prod.endpoint
  cluster_name     = module.gke_region2a_prod.name
  # enable_all            = true
  # managed_control_plane = true
  enable_all = false
  # enable_cluster_roles  = true
  enable_cluster_labels     = true
  enable_namespace_creation = true
  # enable_gcp_apis       = false
  # enable_gcp_iam_roles = false
  enable_gcp_components = true
  enable_registration   = false
  # managed_control_plane = false
  mode            = "install"
  project_id      = data.terraform_remote_state.foundations.outputs.svc_2_project_id
  revision_name   = "asm-1-10"
  custom_overlays = ["./asm_config/multiproject2.yaml"]
}

data "template_file" "multiproject" {
  template = file("${path.module}/asm_config/multiproject.yaml.tmpl")
  vars = {
    mesh_id  = "proj-${data.terraform_remote_state.foundations.outputs.host_project_number}"
    projects = format("%s,%s", data.terraform_remote_state.foundations.outputs.svc_1_project_id, data.terraform_remote_state.foundations.outputs.svc_2_project_id)
  }
}

resource "local_file" "multiproject1" {
  content  = data.template_file.multiproject.rendered
  filename = "${path.module}/asm_config/multiproject1.yaml"
}

resource "local_file" "multiproject2" {
  content  = data.template_file.multiproject.rendered
  filename = "${path.module}/asm_config/multiproject2.yaml"
}
