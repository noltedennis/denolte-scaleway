terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
      version = "~> 2.39.0"
    }
  }
  required_version = ">= 1.8"
}

provider "scaleway" {
  zone   = "fr-par-1"
  region = "fr-par"
}