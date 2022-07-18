provider "google" {
  project = var.project_id
  region  = var.region
}

module "gke" {
  source = "./../.."

  project_id = var.project_id
  region = var.region
  prefix = var.prefix
  environment = var.environment
  name = var.name
  vpc_name = var.vpc_name
  subnetwork = var.subnetwork
  subnet_ip = var.subnet_ip
  master_authorized_networks = var.master_authorized_networks
}