variable "vpc_cidr_block" {
  description = "Cidr range for vpc"
  type        = string
}
variable "pub_sub_count" {
  description = "Number of public subnets"
  type        = number
}

variable "priv_sub_count" {
  description = "Number of private subnets"
  type        = number
}

variable "nat_count" {
  description = "Number of NAT gateways"
  type        = number
}
variable "name" {
  description = "The project name"
  type        = string
}

variable "region" {
  description = "Name of the region"
  type        = string
}

variable "db_username" {
  description = "Name of the db_username"
  type        = string
}

variable "database_name" {
  description = "Name of the db_name"
  type        = string
}


variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
}
