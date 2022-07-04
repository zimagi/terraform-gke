variable "prefix" {
  description = "prefix"
}

variable "environment" {
  description = "env"
}

variable "attributes" {
  description = "attr"
}

variable "name" {
  description = "name"
}

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

variable "subnet_ip" {
  type    = string
  default = "10.0.0.0/17"
}

variable "secondary_ranges_name" {
  default = "secondary_ranges"
}

variable "secondary_ranges_pods_ip_cidr_range" {
  default = "192.168.0.0/18"
}

variable "secondary_ranges_services_ip_cidr_range" {
  default = "192.168.64.0/18"
}
