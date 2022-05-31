module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "5.0.0"

  project_id   = var.project_id
  network_name = "eja-test-zimagi-platform"

  auto_create_subnetworks = false
  shared_vpc_host         = false
  firewall_rules          = var.firewall_rules
  routes                  = var.routes

  subnets = [
    {
      subnet_name   = "eja-test-zimagi-platform"
      subnet_ip     = "10.0.0.0/17"
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    "eja-test-zimagi-platform" = [
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