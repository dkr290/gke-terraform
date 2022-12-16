

variable "region" {
  description = "The region of the GKE"
  default = "europe-north1"
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
  default = "10"

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