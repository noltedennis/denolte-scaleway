terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.39.0"
    }
  }
  required_version = ">= 1.8"

  backend "s3" {
    bucket = "denolte-terraform"
    key    = "kapsule.tfstate"
    region = "fr-par"
    endpoints = {
      s3 = "https://s3.fr-par.scw.cloud"
    }
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
  }
}

provider "scaleway" {
  zone            = "fr-par-1"
  region          = "fr-par"
  organization_id = "3bfd4112-c8a8-41df-af67-f7fb7271648f"
}