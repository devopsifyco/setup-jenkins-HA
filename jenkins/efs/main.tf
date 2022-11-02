module "efs" {
  source  = "cloudposse/efs/aws"
  version = "0.32.7"

  region  = var.region
  vpc_id  = var.vpc_id
  subnets = var.subnets
  access_points = {
    "data" = {
      posix_user = {
        gid            = "1001"
        uid            = "5000"
        secondary_gids = "1002,1003"
      }
      creation_info = {
        gid         = "1001"
        uid         = "5000"
        permissions = "0755"
      }
    }
  }

  additional_security_group_rules = [
    {
      type                     = "ingress"
      from_port                = 2049
      to_port                  = 2049
      protocol                 = "tcp"
      source_security_group_id = var.source_security_group_id
      description              = "Allow ingress traffic to EFS from trusted Security Groups"
    }
  ]

  transition_to_ia = ["AFTER_7_DAYS"]

  security_group_create_before_destroy = false
}