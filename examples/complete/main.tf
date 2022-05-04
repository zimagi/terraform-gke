provider "google" {
  project = var.project_id
  region  = var.region
}

module "gke" {
  source = "./../.."

  region = var.region
  location   = var.location
  project_id = var.project_id

  gke_num_nodes = var.gke_num_nodes
}