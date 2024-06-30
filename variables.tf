variable "scaleway_secret_key" {
  description = "secret of api"
  type        = string
  default     = ""
}

variable "scaleway_access_key" {
  description = "acces of api"
  type        = string
  default     = ""
}

variable "scaleway_project_id" {
description = "ID of project"
  type        = string
  default     = ""
}

variable "vpc" {
  description = "List of VPC"
  type = list(object({
    name = string
    region  = string
    vpc_id  = string
  }))
  default = []
}

variable "clusters" {
  description = "Liste of clusters"
  type = list(object({
    name = string
    cluster_region = string
    cni = string
    cluster_version = string
    pvn_name = string
    delete_additional_resources = bool
    cluster_type = string
    
    auto_upgrade = object({
        enable                        = bool
        maintenance_window_day        = string
        maintenance_window_start_hour = number
    })

    autoscaler_config = object({
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
  }))
  default = []
}


variable "pools" {
  description = "Liste of pools to link to clusters"
  type = list(object({
    name = string
    cluster_name              = string  # Ce champ est utilisé pour associer le pool au bon cluster
    node_type                 = string
    pool_zone                 = string
    autoscaling               = bool
    autohealing               = bool
    root_volume_size_in_gb    = number
    size                      = number
    max_size                  = number
    min_size                  = number
  }))
  default = []
}


variable "instances" {
  description = "List of instance"
  type = list(object({
    name        = string
    type        = string
    image       = string
    enable_ipv6 = bool
    enable_dynamic_ip = bool
    replace_on_type_change = bool
    routed_ip_enabled      = bool
    root_volume = object({
      boot                  = bool
      delete_on_termination = bool
      size_in_gb = number
      type       = string
    })
    additional_volume_ids = list(string)
  }))
  default = []
}

variable "volumes" {
  type = list(object({
  name = string
  size_in_gb = number
  type = string
  }))
  default = []
}

variable "db_instances" {
  description = "List of database instances"
  type = list(object({
    name           = string
    node_type      = string
    engine         = string
    is_ha_cluster  = bool
    disable_backup = bool
    user_name      = string
    password       = string
    region            = string
    volume_type       = string
    volume_size_in_gb = number
  }))
  default = []
}

variable "dbs" {
  description = "List of database"
  type = list(object({
    instance_name           = string
    name      = string
  }))
  default = []
}

variable "db_users" {
  description = "List of user"
  type = list(object({
    instance_name = string
    name        = string
    password    = string
    is_admin    = bool
   }))
  default = []
 }

variable "db_permission" {
  description = "user permission"
  type = list(object({
	instance_name   = string
	user_name     = string
	database_name = string
	permission    = string
  }))
 default = []
}

variable "scaleway_version" {
description = "version of scaleways api"
  type        = string
  default     = ""
}


