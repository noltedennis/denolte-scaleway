resource scaleway_account_project "this" {
  name = "denolte"
}

resource "scaleway_vpc" "this" {
  name = "denolte"
  project_id = scaleway_account_project.this.id
}

resource "scaleway_vpc_private_network" "this" {
  name = "kapsule"
  project_id = scaleway_account_project.this.id
  vpc_id = scaleway_vpc.this.id
  ipv4_subnet {
    subnet = "10.0.0.0/24"
  }
}

resource "scaleway_vpc_public_gateway" "this" {
  name = "denolte"
  type = "VPC-GW-S"
  project_id = scaleway_account_project.this.id
}

resource scaleway_vpc_public_gateway_ip "this" {
  reverse = "k8s.denolte.de"
  project_id = scaleway_account_project.this.id
}

resource "scaleway_k8s_cluster" "this" {
  name    = "denolte"
  type    = "kapsule"
  version = "1.24"
  cni     = "cilium"
  private_network_id = scaleway_vpc_private_network.this.id
  delete_additional_resources = true
  auto_upgrade {
    enable = true
    maintenance_window_start_hour = 3
    maintenance_window_day = "any"
  }
  project_id = scaleway_account_project.this.id
}

resource "scaleway_k8s_pool" "dev1m" {
  cluster_id = scaleway_k8s_cluster.this.id
  name       = "dev1m"
  node_type  = "DEV1-M"
  autoscaling = true
  autohealing = true
  size = 1
  min_size    = 1
  max_size    = 1
  public_ip_disabled = true
}