resource "google_service_account" "svc-gke" {
  account_id = "svc-gke"
  project = data.google_project.dev-k8s.project_id
  display_name = "Service Account GKE"

  depends_on = [
    data.google_project.dev-k8s
  ]
}

resource "google_project_iam_member" "project" {
  project = data.google_project.dev-k8s.project_id
  role    = "roles/containerregistry.ServiceAgent"
  member  = "serviceAccount:${google_service_account.svc-gke.email}"
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
node_locations = [
    "${var.region}-b",
  ]

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

depends_on = [
  google_compute_subnetwork.private
]

}

resource "google_container_node_pool" "general" {
  name       = "general"
  cluster    = google_container_cluster.gke.name
  project = data.google_project.dev-k8s.project_id
  location = var.region
  autoscaling{
    min_node_count = 1
    max_node_count = 2
  }


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
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }
}