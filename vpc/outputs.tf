output "vpc_id" {
  value = module.vpc.vpc_id
}

output "sg_id" {
  value = module.asg_sg.security_group_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}