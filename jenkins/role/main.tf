module "cluster_role" {
  source = "cloudposse/iam-role/aws"
  version = "0.16.2"

  name                     = "${local.global_name}-asg-role"
  enabled                  = true
  instance_profile_enabled = true
  policy_description       = "Allow access base services"
  role_description         = "IAM role with permissions to perform actions on base resources"
  principals = {
    Service = [
      "ec2.amazonaws.com"
    ]
  }
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
  policy_documents = [
    data.aws_iam_policy_document.base_policy.json
  ]

  tags = local.global_tags
}

module "instance_creation_removal_role" {
  source = "cloudposse/iam-role/aws"
  version = "0.16.2"

  enabled            = true
  name               = "${local.global_name}-creation-removal-role"
  policy_description = "instance-creation-removal-role"
  role_description   = "This role used for SSM service"
  principals = {
    Service = [
      "ssm.amazonaws.com"
    ]
  }
  assume_role_actions = ["sts:AssumeRole"]
  policy_documents = [
    data.aws_iam_policy_document.instance_creation_removal_policy.json
  ]
  tags = local.global_tags
}

module "events_rule_instance_creation_removal_role" {
  source = "cloudposse/iam-role/aws"
  version = "0.16.2"

  enabled          = true
  name             = "${local.global_name}-event-role"
  role_description = "This role used for service"
  principals = {
    Service = [
      "events.amazonaws.com"
    ]
  }
  assume_role_actions   = ["sts:AssumeRole"]
  policy_document_count = 0
  policy_documents = [
    data.aws_iam_policy_document.base_policy.json
  ]
  tags = local.global_tags
}

resource "aws_iam_role_policy" "events_rule_instance_creation_removal_policy" {
  name = "${local.global_name}-events-rule-instance-creation-removal-policy"
  role = module.events_rule_instance_creation_removal_role.name
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ssm:StartAutomationExecution",
        "Effect" : "Allow",
        "Resource" : [
          format("%s*", replace(var.document_instance_creation_arn, "document/", "automation-definition/")),
          format("%s*", replace(var.document_instance_removal_arn, "document/", "automation-definition/"))
        ]
      },
      {
        "Action" : "iam:PassRole",
        "Effect" : "Allow",
        "Resource" : "*",
        "Condition" : {
          "StringLikeIfExists" : {
            "iam:PassedToService" : "ssm.amazonaws.com"
          }
        }
      },
      {
        "Action" : "ssm:SendCommand",
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}
