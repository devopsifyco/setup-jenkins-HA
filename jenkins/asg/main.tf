resource "aws_key_pair" "quan" {
  key_name   = "quannhm-01"
  public_key = var.public_key
}

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.2"

  create                          = true
  use_name_prefix                 = false
  name                            = "${local.global_name}-asg"
  vpc_zone_identifier             = var.vpc_zone_identifier
  min_size                        = var.min_size
  max_size                        = var.max_size
  desired_capacity                = var.desired_capacity
  health_check_type               = var.health_check_type
  ignore_desired_capacity_changes = true
  health_check_grace_period       = 30

  # Launch template
  launch_template_name                 = "${local.global_name}-launch-docker"
  instance_name                        = "${local.global_name}-instance"
  create_launch_template               = true
  create_scaling_policy                = false
  instance_type                        = var.instance_type
  instance_initiated_shutdown_behavior = "terminate"
  key_name                             = aws_key_pair.quan.key_name
  iam_instance_profile_arn             = data.aws_iam_instance_profile.linux_profile.arn
  security_groups                      = [var.security_groups]
  update_default_version               = true
  image_id                             = data.aws_ami.amazon_linux_2.id
  enable_monitoring                    = true
  wait_for_capacity_timeout            = var.wait_for_capacity_timeout

  block_device_mappings = [
    {
      device_name = "/dev/sda1"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = false
        volume_size           = 50
        volume_type           = "gp2"
      }
    }
  ]

  target_group_arns = [var.target_group_arns]
  initial_lifecycle_hooks = [
    {
      name                 = "${local.global_name}-TerminationLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 30
      lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
    },
    {
      name                 = "${local.global_name}-StartupLifeCycleHook"
      default_result       = "ABANDON"
      heartbeat_timeout    = 200
      lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
    }
  ]

  tag_specifications = [
    {
      resource_type = "instance"
      tags = merge({
        "Name" = "instance-${local.global_name}"
      }, local.global_tags)
    },
    {
      resource_type = "volume"
      tags = merge({
        "Name" = "volume-${local.global_name}"
      }, local.global_tags)
    }
  ]

  tags = local.global_tags
}