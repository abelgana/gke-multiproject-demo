variable "org_id" {
  type = string
}

variable "billing_id" {
  type = string
}

variable "folder_names" {
  type    = list(string)
  default = ["Multicloud Demo"]
}

variable "host_project" {
  type        = string
  default     = "host"
  description = "Host Project name"
}

variable "bank_svc_project" {
  type        = string
  default     = "svc1"
  description = "Bank Prod"
}

variable "shop_svc_project" {
  type        = string
  default     = "svc2"
  description = "Shop Prod"
}

variable "host_project_apis" {
  type    = list(string)
  default = ["container.googleapis.com", "gkeconnect.googleapis.com", "gkehub.googleapis.com", "anthos.googleapis.com", "multiclusteringress.googleapis.com", "cloudresourcemanager.googleapis.com"]
}

variable "bank_svc_project_apis" {
  type    = list(string)
  default = ["container.googleapis.com", "compute.googleapis.com", "meshca.googleapis.com", "meshtelemetry.googleapis.com", "meshconfig.googleapis.com", "iamcredentials.googleapis.com", "gkeconnect.googleapis.com", "gkehub.googleapis.com", "cloudresourcemanager.googleapis.com", "anthos.googleapis.com", "multiclusteringress.googleapis.com", "stackdriver.googleapis.com"]
}

variable "shop_svc_project_apis" {
  type    = list(string)
  default = ["container.googleapis.com", "compute.googleapis.com", "meshca.googleapis.com", "meshtelemetry.googleapis.com", "meshconfig.googleapis.com", "iamcredentials.googleapis.com", "gkeconnect.googleapis.com", "gkehub.googleapis.com", "cloudresourcemanager.googleapis.com", "anthos.googleapis.com", "multiclusteringress.googleapis.com", "stackdriver.googleapis.com"]
}

variable "region1" {
  type    = string
  default = "us-west2"
}

variable "region2" {
  type    = string
  default = "us-central1"
}

variable "gke1_master_nodes_cidr" {
  default = "172.16.0.0/28"
  type    = string
}

variable "gke2_master_nodes_cidr" {
  default = "172.16.1.0/28"
  type    = string
}

variable "gke3_master_nodes_cidr" {
  default = "172.16.2.0/28"
  type    = string
}

variable "gke4_master_nodes_cidr" {
  default = "172.16.3.0/28"
  type    = string
}
