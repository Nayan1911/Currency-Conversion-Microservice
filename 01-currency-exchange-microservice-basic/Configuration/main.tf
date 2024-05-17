provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "cluster" {
  name    = var.cluster_name
  location = var.zone

  initial_node_count = 1  # Replaces min_count
}


output "cluster_endpoint" {
  value = google_container_cluster.cluster.endpoint
}

