module "main_folder" {
  source  = "terraform-google-modules/folders/google"
  version = "3.1.0"
  parent  = "organizations/${var.org_id}"
  names   = var.folder_names
  # access folder_id using id output
}
