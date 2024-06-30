variable "volumes" {
  type = list(object({
  name = string
  size_in_gb = number
  type = string
  }))
  default = []
}

