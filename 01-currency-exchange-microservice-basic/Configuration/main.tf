provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "cluster" {
  name     = var.cluster_name
  location = var.zone

  node_pool {
    name       = "default-pool"
    machine_type = "n1-standard-1"
    disk_size_gb = 100
    disk_type = "pd-standard"
    min_count = 1
    max_count = 3
  }
}

output "cluster_endpoint" {
  value = google_container_cluster.cluster.endpoint
}
