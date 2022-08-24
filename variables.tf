variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "indent_webhook_secret" {
  type      = string
  sensitive = true
}

variable "auto_approval_duration" {
  type      = string
  default   = ""
  sensitive = true
}

variable "auto_approval_incidentio_roles" {
  type      = string
  default   = ""
  sensitive = true
}

