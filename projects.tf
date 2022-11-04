resource "google_project" "dev-k8s" {
    name = local.service_project_name
    project_id = local.service_project_id
    billing_account = var.billing_id
    org_id = var.org_id
    auto_create_network = false
}

resource "google_project_service" "service" {
    project = google_project.dev-k8s.number
    service = local.projects_api
  
}


