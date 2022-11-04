provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "provider" {}

data "google_container_cluster" "my_cluster" {
  project  = var.project_id
  name     = module.gke.cluster_name
  location = var.region
}

provider "helm" {
  kubernetes {
    host = "https://${data.google_container_cluster.my_cluster.endpoint}"
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate,
    )
    token = data.google_client_config.provider.access_token
  }
}

module "gke" {
  source = "./../.."

  project_id                 = var.project_id
  region                     = var.region
  prefix                     = var.prefix
  environment                = var.environment
  name                       = var.name
  vpc_name                   = var.vpc_name
  subnetwork                 = var.subnetwork
  subnet_ip                  = var.subnet_ip
  master_authorized_networks = var.master_authorized_networks
}