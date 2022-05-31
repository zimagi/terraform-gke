provider "google" {
  project = var.project_id
  region  = var.region
}

module "gke" {
  source = "./../.."

  project_id = var.project_id

  region = var.region
}