variable "origin" {
  description   = "(Required) origin config"
  type          = "map"
}

variable "alias_domain_names" {
  description   = "(Required) alias domain names"
  type          = "list"
}

variable "origin_domain_name" {
  description   = "(Required) origin domain names"
  type          = "string"
}


variable "certificate_arn" {
  description = "(Required) ACM Certificate ARN"
  type = "string"
}

variable "tags" {
  description = "(Optional) Tags for resource"
  type        = "map"
  default = {
    ENV = "TEST"
  }
}

