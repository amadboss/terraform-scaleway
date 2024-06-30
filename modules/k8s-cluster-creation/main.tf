terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

locals {
  private_network_id = var.pvn_ids_map[var.pvn_name]
}

resource "scaleway_k8s_cluster" "this-cluster" {
  name                          = var.name
  project_id  = var.project_id
  version                       = var.cluster_version
  cni                           = var.cni
  region                        = var.cluster_region
  delete_additional_resources = var.delete_additional_resources
  type = var.cluster_type
  
  auto_upgrade {
        enable                        = var.auto_upgrade.enable
        maintenance_window_day        = var.auto_upgrade.maintenance_window_day
        maintenance_window_start_hour = var.auto_upgrade.maintenance_window_start_hour
    }
  
  autoscaler_config {
    balance_similar_node_groups      = var.autoscaler_config.balance_similar_node_groups
    disable_scale_down               = var.autoscaler_config.disable_scale_down
    estimator                        = var.autoscaler_config.estimator
    expander                         = var.autoscaler_config.expander
    expendable_pods_priority_cutoff  = var.autoscaler_config.expendable_pods_priority_cutoff
    ignore_daemonsets_utilization    = var.autoscaler_config.ignore_daemonsets_utilization
    max_graceful_termination_sec     = var.autoscaler_config.max_graceful_termination_sec
    scale_down_delay_after_add       = var.autoscaler_config.scale_down_delay_after_add
    scale_down_unneeded_time         = var.autoscaler_config.scale_down_unneeded_time
    scale_down_utilization_threshold = var.autoscaler_config.scale_down_utilization_threshold
  }
  
  private_network_id = local.private_network_id
}

output "cluster_id" {
  value       = scaleway_k8s_cluster.this-cluster.id
  sensitive   = false
}

