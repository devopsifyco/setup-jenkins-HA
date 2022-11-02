module "instance_creation_logs" {
  source = "cloudposse/cloudwatch-logs/aws"

  name              = "${local.global_name}-instance_creation"
  retention_in_days = 14
}

module "instance_removal_logs" {
  source = "cloudposse/cloudwatch-logs/aws"

  name              = "${local.global_name}-instance_removal"
  retention_in_days = 14
}
