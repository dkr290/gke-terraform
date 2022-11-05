data "google_project" "dev-k8s" {
   
    project_id = local.service_project_id
   
}

data "google_project_service" "service" {
    project = data.google_project.dev-k8s.number
    service = local.projects_api
  
}


