terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

resource "scaleway_instance_volume" "this-volume" {
  for_each = { for volume in var.volumes : volume.name => volume }
  name = each.value.name
  size_in_gb = each.value.size_in_gb
  type = each.value.type
}

output "volume_ids" {
  value =  { for v in var.volumes : v.name => scaleway_instance_volume.this-volume[v.name].id }
}

