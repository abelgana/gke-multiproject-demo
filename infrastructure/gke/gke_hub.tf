resource "google_gke_hub_membership" "gke_region1a_prod" {
  provider      = google-beta
  project       = data.terraform_remote_state.foundations.outputs.host_project_id
  membership_id = module.gke_region1a_prod.name
  endpoint {
    gke_cluster {
      resource_link = module.gke_region1a_prod.cluster_id
    }
  }
  authority {
    issuer = "https://container.googleapis.com/v1/${module.gke_region1a_prod.cluster_id}"
  }

  depends_on = [
    module.gke_region1a_prod,
  ]
}

resource "google_gke_hub_membership" "gke_region2a_prod" {
  provider      = google-beta
  project       = data.terraform_remote_state.foundations.outputs.host_project_id
  membership_id = module.gke_region2a_prod.name
  endpoint {
    gke_cluster {
      resource_link = module.gke_region2a_prod.cluster_id
    }
  }
  authority {
    issuer = "https://container.googleapis.com/v1/${module.gke_region2a_prod.cluster_id}"
  }

  depends_on = [
    module.gke_region2a_prod,
  ]
}
