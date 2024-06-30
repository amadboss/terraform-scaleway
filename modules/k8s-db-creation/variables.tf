variable "db_instances" {
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
  type = list(object({
    instance_name           = string
    name      = string
  }))
  default = []
}

variable "db_users" {
  type = list(object({
    instance_name = string
    name        = string
    password    = string
    is_admin    = bool
   }))
  default = []
 }

variable "db_permission" {
  type = list(object({
        instance_name   = string
        user_name     = string
        database_name = string
        permission    = string
  }))
 default = []
}


