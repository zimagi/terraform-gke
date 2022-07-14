# module "cloudbuild_pool" {
#   source = "./mofules/terraform-google-cloudbuild-pool"
#   depends_on = [
#     module.gke
#   ]

#   pool_name      = var.pool_name
#   location       = var.region
#   peered_network = module.vpc.network_id
# }