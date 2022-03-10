module "gke_region1a_prod" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = module.svc_1_project.project_id
  name                       = "gke-1-prod"
  region                     = module.vpc.subnets["${var.region1}/subnet-01"].region
  zones                      = [format("%s-a", lookup(module.vpc.subnets, "${var.region1}/subnet-01").region)]
  network_project_id         = module.host_project.project_id
  network                    = module.vpc.network_name
  subnetwork                 = module.vpc.subnets["${var.region1}/subnet-01"].name
  ip_range_pods              = "subnet-01-secondary-pods"
  ip_range_services          = "subnet-01-secondary-svc-01"
  identity_namespace         = "${module.svc_1_project.project_id}.svc.id.goog"
  horizontal_pod_autoscaling = true
  enable_private_endpoint    = false
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "172.16.0.0/28"
  add_cluster_firewall_rules = true
  firewall_inbound_ports     = ["10250", "443", "15017", "15014", "8080"]
  kubernetes_version         = "1.21.5-gke.1805"
  cluster_resource_labels = {
    mesh_id = "proj-${module.host_project.project_number}"
  }
  master_authorized_networks = [
    {
      cidr_block   = "${google_compute_address.region1_nat_ip.address}/32"
      display_name = "Nat gw"
    },
    {
      cidr_block   = "${google_compute_address.region2_nat_ip.address}/32"
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
      node_locations = format("%s-a", lookup(module.vpc.subnets, "${var.region1}/subnet-01").region)
      min_count      = 3
      max_count      = 3
      auto_upgrade   = false
      version        = "1.21.5-gke.1805"
    },
  ]
}

# module "gke_region1b_prod" {
#   source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
#   project_id                 = module.svc_1_project.project_id
#   name                       = "gke-2-prod"
#   region                     = module.vpc.subnets["${var.region1}/subnet-01"].region
#   zones                      = [format("%s-a", lookup(module.vpc.subnets, "${var.region1}/subnet-01").region)]
#   network_project_id         = module.host_project.project_id
#   network                    = module.vpc.network_name
#   subnetwork                 = module.vpc.subnets["${var.region1}/subnet-01"].name
#   ip_range_pods              = "subnet-01-secondary-pods"
#   ip_range_services          = "subnet-01-secondary-svc-02"
#   identity_namespace         = "${module.svc_1_project.project_id}.svc.id.goog"
#   horizontal_pod_autoscaling = true
#   enable_private_endpoint    = false
#   enable_private_nodes       = true
#   master_ipv4_cidr_block     = "172.16.1.0/28"
#   add_cluster_firewall_rules = true
#   firewall_inbound_ports     = ["10250", "443", "15017", "15014", "8080"]
#   kubernetes_version         = "1.21.5-gke.1805"
#   cluster_resource_labels = {
#     mesh_id = "proj-${module.host_project.project_number}"
#   }
#   master_authorized_networks = [
#     {
#       cidr_block   = "${google_compute_address.region1_nat_ip.address}/32"
#       display_name = "Nat gw"
#     },
#     {
#       cidr_block   = "${google_compute_address.region2_nat_ip.address}/32"
#       display_name = "Nat gw"
#     },
#     {
#       cidr_block   = "${var.provisionning_ip}/32"
#       display_name = "Local IP"
#     },
#   ]
#   node_pools = [
#     {
#       name           = "gke-region1a-prod-node-pool"
#       machine_type   = "e2-standard-16"
#       node_locations = format("%s-a", lookup(module.vpc.subnets, "${var.region1}/subnet-01").region)
#       min_count      = 1
#       max_count      = 2
#       auto_upgrade   = false
#       version        = "1.21.5-gke.1805"
#     },
#   ]
# }

module "gke_region2a_prod" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = module.svc_2_project.project_id
  name                       = "gke-3-prod"
  region                     = module.vpc.subnets["${var.region2}/subnet-02"].region
  zones                      = [format("%s-a", lookup(module.vpc.subnets, "${var.region2}/subnet-02").region)]
  network_project_id         = module.host_project.project_id
  network                    = module.vpc.network_name
  subnetwork                 = module.vpc.subnets["${var.region2}/subnet-02"].name
  ip_range_pods              = "subnet-02-secondary-pods"
  ip_range_services          = "subnet-02-secondary-svc-01"
  identity_namespace         = "${module.svc_2_project.project_id}.svc.id.goog"
  horizontal_pod_autoscaling = true
  enable_private_endpoint    = false
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "172.16.2.0/28"
  add_cluster_firewall_rules = true
  firewall_inbound_ports     = ["10250", "443", "15017", "15014", "8080"]
  kubernetes_version         = "1.21.5-gke.1805"
  cluster_resource_labels = {
    mesh_id = "proj-${module.host_project.project_number}"
  }
  master_authorized_networks = [
    {
      cidr_block   = "${google_compute_address.region1_nat_ip.address}/32"
      display_name = "Nat gw"
    },
    {
      cidr_block   = "${google_compute_address.region2_nat_ip.address}/32"
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
      node_locations = format("%s-a", lookup(module.vpc.subnets, "${var.region2}/subnet-02").region)
      min_count      = 3
      max_count      = 3
      auto_upgrade   = false
      version        = "1.21.5-gke.1805"
    },
  ]
}

# module "gke_region2b_prod" {
#   source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
#   project_id                 = module.svc_2_project.project_id
#   name                       = "gke-4-prod"
#   region                     = module.vpc.subnets["${var.region2}/subnet-02"].region
#   zones                      = [format("%s-b", lookup(module.vpc.subnets, "${var.region2}/subnet-02").region)]
#   network_project_id         = module.host_project.project_id
#   network                    = module.vpc.network_name
#   subnetwork                 = module.vpc.subnets["${var.region2}/subnet-02"].name
#   ip_range_pods              = "subnet-02-secondary-pods"
#   ip_range_services          = "subnet-02-secondary-svc-02"
#   identity_namespace         = "${module.svc_2_project.project_id}.svc.id.goog"
#   horizontal_pod_autoscaling = true
#   enable_private_endpoint    = false
#   enable_private_nodes       = true
#   master_ipv4_cidr_block     = "172.16.3.0/28"
#   add_cluster_firewall_rules = true
#   firewall_inbound_ports     = ["10250", "443", "15017", "15014", "8080"]
#   kubernetes_version         = "1.21.5-gke.1805"
#   cluster_resource_labels = {
#     mesh_id = "proj-${module.host_project.project_number}"
#   }
#   master_authorized_networks = [
#     {
#       cidr_block   = "${google_compute_address.region1_nat_ip.address}/32"
#       display_name = "Nat gw"
#     },
#     {
#       cidr_block   = "${google_compute_address.region2_nat_ip.address}/32"
#       display_name = "Nat gw"
#     }
#   ]
#   node_pools = [
#     {
#       name           = "gke-region1a-prod-node-pool"
#       machine_type   = "e2-standard-16"
#       node_locations = format("%s-b", lookup(module.vpc.subnets, "${var.region2}/subnet-02").region)
#       min_count      = 1
#       max_count      = 2
#       auto_upgrade   = false
#       version        = "1.21.5-gke.1805"
#     },
#   ]
# }
