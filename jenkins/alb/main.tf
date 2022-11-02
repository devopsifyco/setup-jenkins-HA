module "alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${local.global_name}-alb-sg"
  description = "Security group for example usage with ALB"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}


module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.1.0"

  name = "${local.global_name}-alb"

  load_balancer_type = "application"

  vpc_id          = var.vpc_id
  security_groups = [module.alb_security_group.security_group_id]
  subnets         = var.subnets

  http_tcp_listeners = [
    # Forward action is default, either when defined or undefined
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
      action_type        = "forward"
    }
  ]

  target_groups = [
    {
      name_prefix          = "8080"
      backend_protocol     = "HTTP"
      backend_port         = 8080
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/login"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }
    }
  ]

  http_tcp_listener_rules = [
    {
      http_listener_index = 0
      priority            = 4

      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [
        {
          path_patterns = ["/"]
        }
      ]
    }
  ]

  tags                    = local.global_tags
  lb_tags                 = local.global_tags
  target_group_tags       = local.global_tags
  http_tcp_listeners_tags = local.global_tags
}