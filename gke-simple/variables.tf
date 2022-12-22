

variable "location" {
  description = "The region of the GKE"
  type = string
}
variable "region" {
  description = "The region of the GKE"
  type = string 
}


variable "node_pool_name" {
  type = string
  description = "The nodepool name"
  
}


variable "project_id" {
  description= "The project ID"
}

variable "credentials" {
  type =  string
  description = "Credentials"
  
}

variable "cluster_name" {
    default = "gkedemo1"
    type = string
    description = "GKE cluster name"
  
}
variable "worker_nodes_disk_size" {
  description = "disk size for the VM workes"
  type = string

}

variable "gke_version" {
  description = "fixed gke version cane be discovered by command gcloud container get-server-config"
  type = string
  
}





# Environment varialbe
variable "environment" {
  description = "Environemnt Variable used as prefix"
  type = string
  default = "dev"
  
}

#Business Devision

variable "business_division" {

  description = "Business division in the large organization"
  type = string
  default = "Operations"
  
}

variable "node_locations" {
  description = "The node locations"
  type = list
  
}

variable "subnetwork" {
  description = "the subnet"
  type = string
}