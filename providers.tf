terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.10.0"
    }
  }
}

provider "google" {
  credentials = file("")
  project     = ""
  region      = "europe-west2"
  zone        = "europe-west2-c"
}