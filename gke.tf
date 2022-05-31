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
      auto_upgrade       = false
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
  version = "21.1.0"

  project_id = var.project_id
  name       = "eja-test-zimagi-platform"

  regional          = true
  region            = var.region
  network           = module.vpc.network_name
  subnetwork        = module.vpc.subnets_names[0]
  ip_range_pods     = "pods"
  ip_range_services = "services"

  create_service_account     = true
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  enable_private_endpoint    = true
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "172.16.0.0/28"

  master_authorized_networks = [
    {
      cidr_block   = module.vpc.subnets_ips[0]
      display_name = "VPC"
    },
  ]

  node_pools = local.node_pools
}