variable "name" {
  type = string
}

variable "node_type" {
  type = string
}

variable "pool_zone" {
  type = string
}

variable "size" {
  type = number
}

variable "autoscaling" {
  type = bool
}

variable "autohealing" {
  type = bool
}

variable "root_volume_size_in_gb" {
  type = number
}

variable "cluster_id" {
  type        = string
  default = null
}

variable "min_size" {
  type        = number
}

variable "max_size" {
  type        = number
}

