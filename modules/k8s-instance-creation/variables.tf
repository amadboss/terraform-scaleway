variable "name" {
  type        = string
}

variable "type" {
  type        = string
}

variable "image" {
  type        = string
}

variable "root_volume_type" {
  type        = string
}

variable "root_volume_size_in_gb" {
  type        = number
}

variable "enable_ipv6" {
  type        = bool
}

variable "additional_volume_ids" {
  type        = list(string)
}

variable "enable_dynamic_ip" {
  type        = bool
}

variable "replace_on_type_change" {
  type        = bool
}

variable "routed_ip_enabled" {
  type        = bool
}

variable "boot" {
  type        = bool
}

variable "delete_on_termination" {
  type        = bool
}

