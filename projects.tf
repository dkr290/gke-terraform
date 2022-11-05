data "google_project" "dev-k8s" {
   
}


output "project_number" {
  value = data.google_project.dev-k8s.number
}

output "project_id" {
  value = data.google_project.dev-k8s.project_id
}



resource "google_project_service" "service" {
    project = data.google_project.dev-k8s.project_number
    service = local.projects_api
  
}


