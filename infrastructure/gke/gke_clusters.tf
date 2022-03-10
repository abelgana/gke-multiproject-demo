module "gke_region1a_prod" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = data.terraform_remote_state.foundations.outputs.svc_1_project_id
  name                       = "gke-1-prod"
  region                     = data.terraform_remote_state.foundations.outputs.subnet_1_region
  zones                      = [format("%s-a", data.terraform_remote_state.foundations.outputs.subnet_1_region)]
  network_project_id         = data.terraform_remote_state.foundations.outputs.host_project_id
  network                    = data.terraform_remote_state.foundations.outputs.vpc_name
  subnetwork                 = data.terraform_remote_state.foundations.outputs.subnet_1_name
  ip_range_pods              = data.terraform_remote_state.foundations.outputs.svc_1_pod_subnet
  ip_range_services          = data.terraform_remote_state.foundations.outputs.svc_1_svc_subnet
  identity_namespace         = "${data.terraform_remote_state.foundations.outputs.svc_1_project_id}.svc.id.goog"
  horizontal_pod_autoscaling = true
  enable_private_endpoint    = false
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "172.16.0.0/28"
  add_cluster_firewall_rules = true
  firewall_inbound_ports     = ["10250", "443", "15017", "15014", "8080"]
  kubernetes_version         = "1.21.5-gke.1805"
  cluster_resource_labels = {
    mesh_id = "proj-${data.terraform_remote_state.foundations.outputs.host_project_number}"
  }
  master_authorized_networks = [
    {
      cidr_block   = "${data.terraform_remote_state.foundations.outputs.region_1_nat_ip}/32"
      display_name = "Nat gw"
    },
    {
      cidr_block   = "${data.terraform_remote_state.foundations.outputs.region_2_nat_ip}/32"
      display_name = "Nat gw"
    },
    {
      cidr_block   = "${var.provisionning_ip}/32"
      display_name = "Local IP"
    },
  ]
  node_pools = [
    {
      name           = "gke-region1a-prod-node-pool"
      machine_type   = "e2-standard-8"
      node_locations = format("%s-a", data.terraform_remote_state.foundations.outputs.subnet_1_region)
      min_count      = 3
      max_count      = 3
      auto_upgrade   = false
      version        = "1.21.5-gke.1805"
    },
  ]
}

module "gke_region2a_prod" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = data.terraform_remote_state.foundations.outputs.svc_2_project_id
  name                       = "gke-3-prod"
  region                     = data.terraform_remote_state.foundations.outputs.subnet_2_region
  zones                      = [format("%s-a", data.terraform_remote_state.foundations.outputs.subnet_2_region)]
  network_project_id         = data.terraform_remote_state.foundations.outputs.host_project_id
  network                    = data.terraform_remote_state.foundations.outputs.vpc_name
  subnetwork                 = data.terraform_remote_state.foundations.outputs.subnet_2_name
  ip_range_pods              = data.terraform_remote_state.foundations.outputs.svc_2_pod_subnet
  ip_range_services          = data.terraform_remote_state.foundations.outputs.svc_2_svc_subnet
  identity_namespace         = "${data.terraform_remote_state.foundations.outputs.svc_2_project_id}.svc.id.goog"
  horizontal_pod_autoscaling = true
  enable_private_endpoint    = false
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "172.16.2.0/28"
  add_cluster_firewall_rules = true
  firewall_inbound_ports     = ["10250", "443", "15017", "15014", "8080"]
  kubernetes_version         = "1.21.5-gke.1805"
  cluster_resource_labels = {
    mesh_id = "proj-${data.terraform_remote_state.foundations.outputs.host_project_number}"
  }
  master_authorized_networks = [
    {
      cidr_block   = "${data.terraform_remote_state.foundations.outputs.region_1_nat_ip}/32"
      display_name = "Nat gw"
    },
    {
      cidr_block   = "${data.terraform_remote_state.foundations.outputs.region_2_nat_ip}/32"
      display_name = "Nat gw"
    },
    {
      cidr_block   = "${var.provisionning_ip}/32"
      display_name = "Local IP"
    },
  ]
  node_pools = [
    {
      name           = "gke-region2a-prod-node-pool"
      machine_type   = "e2-standard-8"
      node_locations = format("%s-a", data.terraform_remote_state.foundations.outputs.subnet_2_region)
      min_count      = 3
      max_count      = 3
      auto_upgrade   = false
      version        = "1.21.5-gke.1805"
    },
  ]
}
