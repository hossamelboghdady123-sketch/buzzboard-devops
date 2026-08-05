variable "project_name" {
  type    = string
  default = "buzzboard"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "aws_region" {
  type    = string
  default = "eu-north-1"
}
variable "db_password" {
  description = "PostgreSQL database password"
  type        = string
  sensitive   = true
}
