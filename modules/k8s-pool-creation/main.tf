terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
} 

resource "scaleway_k8s_pool" "this-pool" {
  cluster_id = var.cluster_id 
  name                   = var.name
  node_type              = var.node_type
  zone                   = var.pool_zone
  size                   = var.size
  autoscaling            = var.autoscaling
  autohealing            = var.autohealing
  root_volume_size_in_gb = var.root_volume_size_in_gb
  max_size               = var.max_size
  min_size               = var.min_size
}
