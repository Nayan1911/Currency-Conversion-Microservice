terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      #version = "3.76.0"
    }
}
}

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "cluster_name" {
  type = string
}
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

