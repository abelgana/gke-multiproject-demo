module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 5.0"

  project_id   = module.host_project.project_id
  network_name = "shared-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.4.0.0/22"
      subnet_region = var.region1
    },
    {
      subnet_name   = "subnet-02"
      subnet_ip     = "10.12.0.0/22"
      subnet_region = var.region2
    }
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-pods"
        ip_cidr_range = "10.0.0.0/14"
      },
      {
        range_name    = "subnet-01-secondary-svc-01"
        ip_cidr_range = "10.5.0.0/20"
      },
      {
        range_name    = "subnet-01-secondary-svc-02"
        ip_cidr_range = "10.5.16.0/20"
      },
    ]

    subnet-02 = [
      {
        range_name    = "subnet-02-secondary-pods"
        ip_cidr_range = "10.8.0.0/14"
      },
      {
        range_name    = "subnet-02-secondary-svc-01"
        ip_cidr_range = "10.13.0.0/20"
      },
      {
        range_name    = "subnet-02-secondary-svc-02"
        ip_cidr_range = "10.13.16.0/20"
      },
    ]
  }
  firewall_rules = local.default_fw
}

resource "google_compute_router" "region1_router" {
  name    = "${module.vpc.subnets_regions[0]}-router"
  region  = module.vpc.subnets_regions[0]
  network = module.vpc.network_name
  project = module.vpc.project_id
}

resource "google_compute_router_nat" "region1_nat" {
  name                               = "${google_compute_router.region1_router.region}-nat"
  router                             = google_compute_router.region1_router.name
  region                             = google_compute_router.region1_router.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ips                            = google_compute_address.region1_nat_ip.*.self_link
  project                            = module.vpc.project_id
  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_router" "region2_router" {
  name    = "${module.vpc.subnets_regions[1]}-router"
  region  = module.vpc.subnets_regions[1]
  network = module.vpc.network_name
  project = module.vpc.project_id
}

resource "google_compute_router_nat" "region2_nat" {
  name                               = "${google_compute_router.region2_router.region}-nat"
  router                             = google_compute_router.region2_router.name
  region                             = google_compute_router.region2_router.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ips                            = google_compute_address.region2_nat_ip.*.self_link
  project                            = module.vpc.project_id
  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_address" "region1_nat_ip" {
  name         = "${var.region1}-nat-ip"
  address_type = "EXTERNAL"
  region       = module.vpc.subnets_regions[0]
  project      = module.vpc.project_id
}

resource "google_compute_address" "region2_nat_ip" {
  name         = "${var.region2}-nat-ip"
  address_type = "EXTERNAL"
  region       = module.vpc.subnets_regions[1]
  project      = module.vpc.project_id
}

locals {
  default_fw = [
    {
      "name"      = "gke-apis-to-pods"
      "direction" = "INGRESS"
      "priority"  = 1000
      "ranges"    = ["10.0.0.0/8", var.gke1_master_nodes_cidr, var.gke2_master_nodes_cidr, var.gke3_master_nodes_cidr, var.gke4_master_nodes_cidr]
      "allow"     = [{ protocol = "all", ports = [] }]
    },
  ]
}
