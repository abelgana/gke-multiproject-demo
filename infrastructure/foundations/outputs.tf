output "host_project_id" {
  value = module.host_project.project_id
}

output "svc_1_project_id" {
  value = module.svc_1_project.project_id
}

output "svc_2_project_id" {
  value = module.svc_2_project.project_id
}

output "host_project_number" {
  value = module.host_project.project_number
}

output "svc_1_project_number" {
  value = module.svc_1_project.project_number
}

output "svc_2_project_number" {
  value = module.svc_2_project.project_number
}

output "vpc_name" {
  value = module.vpc.network_name
}

output "subnet_1_region" {
  value = module.vpc.subnets["${var.region1}/subnet-01"].region
}

output "subnet_2_region" {
  value = module.vpc.subnets["${var.region2}/subnet-02"].region
}

output "subnet_1_name" {
  value = module.vpc.subnets["${var.region1}/subnet-01"].name
}

output "subnet_2_name" {
  value = module.vpc.subnets["${var.region2}/subnet-02"].name
}

output "region_1_nat_ip" {
  value = google_compute_address.region1_nat_ip.address
}

output "region_2_nat_ip" {
  value = google_compute_address.region2_nat_ip.address
}

output "svc_1_pod_subnet" {
  value = "subnet-01-secondary-pods"
}

output "svc_2_pod_subnet" {
  value = "subnet-02-secondary-pods"
}

output "svc_1_svc_subnet" {
  value = "subnet-01-secondary-svc-01"
}

output "svc_2_svc_subnet" {
  value = "subnet-02-secondary-svc-01"
}
