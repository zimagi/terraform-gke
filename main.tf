resource "google_service_account" "this" {
  account_id   = "${var.project_id}-gke"
  display_name = "${var.project_id}-gke"
}

resource "google_compute_subnetwork" "this" {
  name          = "${var.project_id}-gke"
  ip_cidr_range = "10.5.0.0/20"
  region        = var.region
  network       = google_compute_network.this.id
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.4.0.0/19"
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "10.0.0.0/14"
  }
}

resource "google_compute_network" "this" {
  name                    = "${var.project_id}-gke"
  auto_create_subnetworks = false
}

resource "google_container_cluster" "this" {
  name     = "${var.project_id}-gke"
  location = var.location

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.this.id
  subnetwork = google_compute_subnetwork.this.id

  ip_allocation_policy {
    cluster_secondary_range_name  = "services-range"
    services_secondary_range_name = google_compute_subnetwork.this.secondary_ip_range.1.range_name
  }

  node_config {
    service_account = google_service_account.this.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }

    gcp_filestore_csi_driver_config {
      enabled = true
    }
  }

  lifecycle {
    ignore_changes = [node_config]
  }

}

resource "google_container_node_pool" "this" {
  name       = "${var.project_id}-gke"
  location   = var.location
  cluster    = google_container_cluster.this.name
  node_count = var.gke_num_nodes

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    service_account = google_service_account.this.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  lifecycle {
    ignore_changes = [node_config]
  }
}