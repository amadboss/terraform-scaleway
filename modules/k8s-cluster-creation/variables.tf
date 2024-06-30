variable "name" {
  type = string
}

variable "cluster_region" {
  type = string
}

variable "cni" {
  type = string
}

variable "project_id" {
  type        = string
}

variable "cluster_version" {
  type        = string
}

variable "delete_additional_resources" {
  type        = bool
}

variable "pvn_id" {
  type        = string
  default = null
}

variable "pvn_name" {
type = string
}

variable "pvn_ids_map" {
  type        = map(string)
}

variable "cluster_type" {
  type        = string
}

variable "autoscaler_config" {
  type = object({
    balance_similar_node_groups      = bool
    disable_scale_down               = bool
    estimator                        = string
    expander                         = string
    expendable_pods_priority_cutoff  = number
    ignore_daemonsets_utilization    = bool
    max_graceful_termination_sec     = number
    scale_down_delay_after_add       = string
    scale_down_unneeded_time         = string
    scale_down_utilization_threshold = number
  })
}

variable auto_upgrade {
  type = object({
    enable                        = bool
    maintenance_window_day        = string
    maintenance_window_start_hour = number
  })
}

