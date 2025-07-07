variable "vpc_cidr_block" {
  description = "Cidr range for vpc"
  type        = string
}

variable "name" {
  description = "Name to be used on VPC created"
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