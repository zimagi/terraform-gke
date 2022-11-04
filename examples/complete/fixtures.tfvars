region      = "europe-central2"
project_id  = "zimagi-development-e0b1"
prefix      = "zimagi"
environment = "develop"
name        = "zimagi"
subnetwork  = "gke"
subnet_ip   = "10.0.0.0/17"
master_authorized_networks = [
  {
    cidr_block   = "192.168.0.0/20"
    display_name = "VPN"
  }
]