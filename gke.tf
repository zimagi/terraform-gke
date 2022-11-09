locals {
  platform_nodes = [
    {
      name               = "platform-pool"
      machine_type       = "n2-standard-2"
      min_count          = 1
      max_count          = 10
      disk_size_gb       = 10
      disk_type          = "pd-ssd"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
      initial_node_count = 1
    },
  ]
}

locals {
  cluster_type = "simple-zonal-private"
  node_pools   = concat(var.node_pools, local.platform_nodes)
}

data "google_client_config" "default" {}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version = "22.1.0"

  project_id = var.project_id
  name       = local.cluster_name

  regional          = true
  region            = var.region
  network           = var.vpc_name == "" ? module.vpc[0].network_name : var.vpc_name
  subnetwork        = var.vpc_name == "" ? module.vpc[0].subnets_names[0] : var.subnetwork
  ip_range_pods     = "pods"
  ip_range_services = "services"

  create_service_account      = true
  http_load_balancing         = false
  network_policy              = false
  horizontal_pod_autoscaling  = true
  filestore_csi_driver        = false
  enable_private_endpoint     = var.enable_private_endpoint
  enable_private_nodes        = var.enable_private_nodes
  master_ipv4_cidr_block      = var.master_ipv4_cidr_block
  enable_binary_authorization = true
  kubernetes_version          = var.kubernetes_version
  release_channel             = var.release_channel

  remove_default_node_pool = var.remove_default_node_pool

  master_authorized_networks = concat([
    {
      cidr_block   = try(module.vpc[0].subnets_ips[0], var.subnet_ip)
      display_name = "VPC"
    },
    ],
  var.master_authorized_networks)

  node_pools = local.node_pools
}