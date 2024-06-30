terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

resource "scaleway_instance_server" "this-instance" {

  name = var.name
  type = var.type
  image = var.image 
  enable_ipv6 = var.enable_ipv6
  replace_on_type_change = var.replace_on_type_change
  routed_ip_enabled      = var.routed_ip_enabled 
  
  root_volume {
    boot                  = var.boot
    delete_on_termination = var.delete_on_termination
    volume_type       = var.root_volume_type
    size_in_gb = var.root_volume_size_in_gb
  }
  additional_volume_ids = var.additional_volume_ids
}

