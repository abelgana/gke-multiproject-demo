resource "google_gke_hub_membership" "gke_region1a_prod" {
  provider      = google-beta
  project       = module.host_project.project_id
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
    module.gkehub_iam_bindings,
    module.gke_region1a_prod,
  ]
}

# resource "google_gke_hub_membership" "gke_region1b_prod" {
#   provider      = google-beta
#   project       = module.host_project.project_id
#   membership_id = module.gke_region1b_prod.name
#   endpoint {
#     gke_cluster {
#       resource_link = module.gke_region1b_prod.cluster_id
#     }
#   }
#   authority {
#     issuer = "https://container.googleapis.com/v1/${module.gke_region1b_prod.cluster_id}"
#   }

#   depends_on = [
#     module.gkehub_iam_bindings,
#     module.gke_region1b_prod,
#   ]
# }

resource "google_gke_hub_membership" "gke_region2a_prod" {
  provider      = google-beta
  project       = module.host_project.project_id
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
    module.gkehub_iam_bindings,
    module.gke_region2a_prod,
  ]
}

# resource "google_gke_hub_membership" "gke_region2b_prod" {
#   provider      = google-beta
#   project       = module.host_project.project_id
#   membership_id = module.gke_region2b_prod.name
#   endpoint {
#     gke_cluster {
#       resource_link = module.gke_region2b_prod.cluster_id
#     }
#   }
#   authority {
#     issuer = "https://container.googleapis.com/v1/${module.gke_region2b_prod.cluster_id}"
#   }

#   depends_on = [
#     module.gkehub_iam_bindings,
#     module.gke_region2b_prod,
#   ]
# }
