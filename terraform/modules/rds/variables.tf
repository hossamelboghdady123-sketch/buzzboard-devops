variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "rds_security_group_id" {
  type = string
}

variable "db_name" {
  type    = string
  default = "buzzboard"
}

variable "db_username" {
  type    = string
  default = "postgres"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}
variable "db_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}
