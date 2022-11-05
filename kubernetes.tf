resource "google_service_account" "svc-gke" {
  account_id = "svc-gke"
  project = data.google_project.dev-k8s.project_id

  depends_on = [
    data.google_project.dev-k8s
  ]
}

resource "google_container_cluster" "gke" {
  name               = local.gke_cluster_name
  location           = var.region
  initial_node_count = 1
  project = data.google_project.dev-k8s.project_id
  networking_mode = "VPC_NATIVE"
  network = google_compute_network.vpc_network.self_link
  subnetwork = google_compute_subnetwork.private.self_link
  remove_default_node_pool = true

  release_channel {
    channel = "REGULAR"
  }

  ip_allocation_policy {
    cluster_secondary_range_name = "pod-ip-range"
    services_secondary_range_name = "services-ip-range"

  }

  network_policy {
    provider = "PROVIDER_UNSPECIFIED"
    enabled = true
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes = true
    master_ipv4_cidr_block = "172.16.0.0/28"
  }

workload_identity_config {
  workload_pool= "${data.google_project.dev-k8s.project_id}.svc.id.goog"
}

}

resource "google_container_node_pool" "general" {
  name       = "general"
  cluster    = google_container_cluster.gke.name
  project = data.google_project.dev-k8s.project_id
  location = var.region
  node_count = 1


management {
  auto_repair = true
  auto_upgrade = true
}
  node_config {
    labels = {
      "role" = "general"
    }
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.svc-gke.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}