data "terraform_remote_state" "foundations" {
  backend = "local"

  config = {
    path = "../foundations/terraform.tfstate"
  }
}
