provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "cluster" {
  name    = var.cluster_name
  location = var.zone

  initial_node_count = 1  # Replaces min_count
  node_pool_default {  # Replaces node_pool block
    machine_type = "n1-standard-1"
    disk_size_gb  = 100
    disk_type    = "pd-standard"
  }
}

output "cluster_endpoint" {
  value = google_container_cluster.cluster.endpoint
}

