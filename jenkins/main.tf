module "this_alb" {
  source      = "./alb"
  global_name = var.global_name
  global_tags = var.global_tags
  subnets     = var.vpc_zone_identifier
  vpc_id      = var.vpc_id
}

module "this_asg" {
  source                    = "./asg"
  global_name               = var.global_name
  global_tags               = var.global_tags
  instance_profile          = module.this_role.instance_profile
  instance_type             = var.instance_type
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  security_groups           = var.security_groups
  vpc_zone_identifier       = var.vpc_zone_identifier
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  health_check_type         = var.health_check_type
  public_key                = var.public_key

  depends_on = [
    module.this_role
  ]
  target_group_arns = join("", module.this_alb.target_group_arns)
}

module "this_log" {
  source      = "./log"
  global_name = var.global_name
  global_tags = var.global_tags
}

module "this_ssm" {
  source                 = "./ssm"
  global_name            = var.global_name
  global_tags            = var.global_tags
  instance_creation_logs = module.this_log.log_creation
  instance_removal_logs  = module.this_log.log_removal
  role_execute_arn       = module.this_role.role_execute_arn
  mount_target_dns       = module.this_efs.mount_target_dns
}

module "this_role" {
  source                         = "./role"
  global_name                    = var.global_name
  global_tags                    = var.global_tags
  document_instance_creation_arn = module.this_ssm.document_instance_creation_arn
  document_instance_removal_arn  = module.this_ssm.document_instance_removal_arn
}

module "this_event" {
  source                         = "./event"
  document_instance_creation_arn = module.this_ssm.document_instance_creation_arn
  document_instance_removal_arn  = module.this_ssm.document_instance_removal_arn
  global_name                    = var.global_name
  global_tags                    = var.global_tags
  role_trigger_arn               = module.this_role.role_trigger_arn
}

module "this_efs" {
  source                   = "./efs"
  region                   = var.region
  source_security_group_id = var.security_groups
  subnets                  = var.vpc_zone_identifier
  vpc_id                   = var.vpc_id
}