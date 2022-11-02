module "this_vpc" {
  source          = "./vpc"
  cidr            = var.cidr
  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
  egress_rules             = var.egress_rules
  global_name              = module.this.id
  global_tags              = module.this.tags
}

module "this_jenkins" {
  source                    = "./jenkins"
  desired_capacity          = var.desired_capacity
  global_name               = module.this.id
  global_tags               = module.this.tags
  instance_type             = var.instance_type
  max_size                  = var.max_size
  min_size                  = var.min_size
  security_groups           = module.this_vpc.sg_id
  vpc_zone_identifier       = module.this_vpc.public_subnets
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  health_check_type         = var.health_check_type
  public_key                = var.public_key
  vpc_id                    = module.this_vpc.vpc_id
  region                    = var.region
}