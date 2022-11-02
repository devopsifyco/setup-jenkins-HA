module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = "${local.global_name}-demo"
  cidr = var.cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.global_tags
}

module "asg_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${local.global_name}-sg"
  description = "A security group"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks

  egress_rules = var.egress_rules

  tags = local.global_tags
}