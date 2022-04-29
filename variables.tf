variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "location" {
  description = "location"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}