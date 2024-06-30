variable "project_id" {
  type        = string
}

variable "vpcs" {
  description = "List of VPC configurations"
  type = list(object({
    name   = string
    region = string
    vpc_id = string
  }))
  default = []
}

