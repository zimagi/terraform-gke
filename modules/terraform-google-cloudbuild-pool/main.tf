resource "google_compute_network" "pool" {
  project = var.project_id
  name                    = "eja-pool-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_global_address" "pool" {
  project = var.project_id

  name          = "eja-worker-pool-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.pool.id
}

resource "google_service_networking_connection" "worker_pool_conn" {
  network                 = google_compute_network.pool.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.pool.name]
}

resource "google_cloudbuild_worker_pool" "pool" {
  project = var.project_id

  name          = var.pool_name
  location      = var.location
  dynamic "worker_config" {
    for_each = var.worker_config
    content {
      disk_size_gb = worker_config.value.disk_size_gb
      machine_type = worker_config.value.machine_type
      no_external_ip = worker_config.value.no_external_ip
    }
  }

  network_config {
    peered_network = google_compute_network.pool.id
  }
}