variable "project_id" {
  description = "The ID of the project where this VPC will be created"
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "routes" {
  type        = list(map(string))
  description = "List of routes being created in this VPC"
  default     = []
}

variable "firewall_rules" {
  type        = any
  description = "List of firewall rules"
  default     = []
}

variable "node_pools" {
  default = []
}