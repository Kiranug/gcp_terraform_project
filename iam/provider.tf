terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.26.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  project  = var.project_id  
  region   = var.region
}

data "google_project" "project" {
  project_id = var.project_id
}

