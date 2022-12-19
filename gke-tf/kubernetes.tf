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
  location           = var.location
  initial_node_count = 1
  project = data.google_project.dev-k8s.project_id
  networking_mode = "VPC_NATIVE"
  network = google_compute_network.vpc_network.self_link
  subnetwork = google_compute_subnetwork.private.self_link
  remove_default_node_pool = false


    maintenance_policy {
         daily_maintenance_window {
        start_time = "03:00"
       }
   }
    release_channel {
    channel = "REGULAR" // or less frequently update fro production STABLE
    }
  node_locations = [
    "${var.location}",
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
addons_config{
  gcp_filestore_csi_driver_config {
    enabled = true
  }
}
workload_identity_config {
  workload_pool= "${data.google_project.dev-k8s.project_id}.svc.id.goog"
}

depends_on = [
  google_compute_subnetwork.private
]

}