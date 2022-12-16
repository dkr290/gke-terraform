terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.0"
    }
    random = {
        source = "hashicorp/random"
        version = "~> 3.4"
    }
  }
}

provider "google" {
  # Configuration options

  region = "europe-north1"
}

terraform {
 backend "gcs" {
   bucket  = "terraformstate80"
   prefix  = "terraform/state"
   credentials = "/tmp/key.json" 
 }
}

resource "random_integer" "int" {
    min =100
    max = 10000
  
}