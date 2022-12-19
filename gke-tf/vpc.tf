resource "google_compute_network" "vpc_network" {
  project                 = data.google_project.dev-k8s.project_id
  name                    = "vpc-network"
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
  mtu                     = 1500
}


resource "google_compute_subnetwork" "private" {
  name          = "private"
  project = data.google_project.dev-k8s.project_id
  ip_cidr_range = "10.5.0.0/20"
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
  private_ip_google_access = true

  dynamic "secondary_ip_range"{
      for_each = local.secondary_ip_ranges

      content {
        range_name = secondary_ip_range.key
        ip_cidr_range = secondary_ip_range.value
      }
  }

}