module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "5.0.0"

  project_id   = var.project_id
  network_name = local.vpc_name

  auto_create_subnetworks = false
  shared_vpc_host         = false
  firewall_rules          = var.firewall_rules
  routes                  = var.routes

  subnets = [
    {
      subnet_name   = local.subnet_name
      subnet_ip     = var.subnet_ip
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    "${local.subnet_name}" = [
      {
        range_name    = "pods"
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name    = "services"
        ip_cidr_range = "192.168.64.0/18"
      },
    ]
  }
}