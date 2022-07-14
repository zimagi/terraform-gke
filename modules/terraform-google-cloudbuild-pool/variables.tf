variable "location" {
  description = "The location for the resource."
  type        = string
}

variable "create_vpc" {
  description = ""
  type        = bool
  default     = false
}

variable "vpc_name" {
  description = ""
  type        = string
  default     = ""
}

variable "pool_name" {
  description = "User-defined name of the WorkerPool."
  type        = string
}


variable "peered_network" {
  description = "The network definition that the workers are peered to. If this section is left empty, the workers will be peered to WorkerPool.project_id on the service producer network. Must be in the format projects/{project}/global/networks/{network}, where {project} is a project number, such as 12345, and {network} is the name of a VPC network in the project."
  type        = string
  default     = null
}

variable "project_id" {
  description = "The project for the resource."
  type        = string
  default = "zimagi-cloudbuild-8f0d"
}

variable "worker_config" {
  description = "Configuration to be used for a creating workers in the WorkerPool."
  # type = object({
  #   disk_size_gb   = string
  #   machine_type   = string
  #   no_external_ip = bool
  # })
  default = {
    wk = {
      disk_size_gb   = "100"
      machine_type   = "e2-medium"
      no_external_ip = false
    }
  }
}