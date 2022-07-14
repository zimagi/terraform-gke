provider "google" {}

module "vpn-ha-to-mgmt" {
  source  = "terraform-google-modules/vpn/google//modules/vpn_ha"
  version = "2.3.0"

  project_id       = var.prod_project_id
  region           = var.region
  network          = var.prod_network_self_link
  name             = "eja-gke-to-build"
  router_asn       = 64513
  peer_gcp_gateway = module.vpn-ha-to-prod.self_link
  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.1.2"
        asn     = 64514
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.1.1/30"
      ike_version                     = 2
      vpn_gateway_interface           = 0
      peer_external_gateway_interface = null
      shared_secret                   = module.vpn-ha-to-prod.random_secret
    }
    remote-1 = {
      bgp_peer = {
        address = "169.254.2.2"
        asn     = 64514
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.2.1/30"
      ike_version                     = 2
      vpn_gateway_interface           = 1
      peer_external_gateway_interface = null
      shared_secret                   = module.vpn-ha-to-prod.random_secret
    }
  }
}

module "vpn-ha-to-prod" {
  source  = "terraform-google-modules/vpn/google//modules/vpn_ha"
  version = "2.3.0"

  project_id       = var.mgt_project_id
  region           = var.region
  network          = var.mgt_network_self_link
  name             = "mgmt-to-prod"
  peer_gcp_gateway = module.vpn-ha-to-mgmt.self_link
  router_asn       = 64514
  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.1.1"
        asn     = 64513
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.1.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 0
      peer_external_gateway_interface = null
      shared_secret                   = ""
    }
    remote-1 = {
      bgp_peer = {
        address = "169.254.2.1"
        asn     = 64513
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.2.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 1
      peer_external_gateway_interface = null
      shared_secret                   = ""
    }
  }
}

/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "mgt_gateway_name" {
  description = "Mgt VPN gateway name."
  value       = module.vpn-ha-to-prod.name
}

output "prod_gateway_name" {
  description = "Prod VPN gateway name."
  value       = module.vpn-ha-to-mgmt.name
}

output "prod_tunnel_names" {
  description = "Prod VPN tunnel names."
  value       = module.vpn-ha-to-mgmt.tunnel_names
  sensitive   = true
}

output "mgt_tunnel_names" {
  description = "Mgt VPN tunnel names."
  value       = module.vpn-ha-to-prod.tunnel_names
  sensitive   = true
}

/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "prod_project_id" {
  description = "Production Project ID."
  type        = string
}

variable "prod_network_self_link" {
  description = "Production Network Self Link."
  type        = string
}

variable "mgt_project_id" {
  description = "Management Project ID."
  type        = string
}

variable "mgt_network_self_link" {
  description = "Management Network Self Link."
  type        = string
}

variable "region" {
  description = "Region."
  type        = string
  default     = "europe-west4"
}