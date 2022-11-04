variable "org_id" {
    description = "This is the organization ID for the project"
  
}

variable "region" {
  default = "The region of the GKE"
}

variable "billing_id" {
  description = "The Billing id"
}

variable "cluster_name" {
    default = "gkedemo1"
    type = string
    description = "GKE cluster name"
  
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