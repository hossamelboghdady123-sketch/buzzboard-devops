variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "eks_security_group_id" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.33"
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.small"]
}

variable "kms_key_arn" {
  description = "KMS Key ARN used for EKS secrets encryption"
  type        = string
}
