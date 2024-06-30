terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

resource "scaleway_vpc_private_network" "this_pvn" {
  for_each = { for v in var.vpcs : v.name => v }
  

  project_id = var.project_id
  name       = each.value.name
  region     = each.value.region
  vpc_id     = each.value.vpc_id
}


output "pvn_ids" {
value = { 
    for v in var.vpcs : v.name => scaleway_vpc_private_network.this_pvn[v.name].id
  }
}
