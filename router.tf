resource "google_compute_router"  "router" {
    name = "router"
    region = var.region
    project = google_project.dev-k8s.project_id
    network = google_compute_network.vpc_network.self_link
}