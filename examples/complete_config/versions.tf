terraform {
  required_version = ">= 0.13.0"
  required_providers {
    gcp = {
      source  = "hashicorp/google"
      version = "~> 4.9.0"
    }
  }
}
