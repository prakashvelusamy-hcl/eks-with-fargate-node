output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "eks_oidc_root_ca_thumbprint" {
  value = module.eks.eks_oidc_root_ca_thumbprint
}

