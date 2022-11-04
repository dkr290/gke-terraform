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

  region = "us-west2"
}

resource "random_integer" "int" {
    min =100
    max = 10000
  
}