locals {
  owners = lower("${var.business_division}")
  environment = var.environment
 # name = "${var.business_division}-${var.environment}"

 name = "${local.owners}-${local.environment}"
 common_tags ={
    owners = local.owners
    environment = local.environment
 }

 service_project_name = "dev-k8s"
 service_project_id =  "${local.service_project_name}-${random_integer.int.result}"
 projects_api = "container.googleapis.com"
 
 secondary_ip_ranges = {
    "pod-ip-range" = "10.0.0.0/14",
    "services-ip-range"= "10.20.0.0/19"

 }
 
 gke_cluster_name = "${local.name}-${var.cluster_name}"

}