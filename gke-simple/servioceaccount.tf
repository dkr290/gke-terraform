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
