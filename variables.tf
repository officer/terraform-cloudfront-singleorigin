variable "origin" {
  description   = "(Required) origin config"
  type          = "map"
}

variable "domain_name" {
  description   = "(Required) origin domain names"
  type          = "list"
}

variable "certificate_arn" {
  description = "(Required) ACM Certificate ARN"
  type = "string"
}