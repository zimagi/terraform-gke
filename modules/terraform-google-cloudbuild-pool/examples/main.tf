module "cb" {
  source     = "./.."
  project_id = "zimagi-cloudbuild-214c"

  location   = "us-east4"
  create_vpc = true
  pool_name  = "eja-ppool"
}