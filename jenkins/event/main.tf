resource "aws_cloudwatch_event_rule" "event_instance_creation" {
  name        = "${local.global_name}-instance_creation"
  description = "Capture each AWS Console Sign In"
  event_pattern = jsonencode({
    "source" : [
      "aws.autoscaling"
    ],
    "detail-type" : [
      "EC2 Instance-launch Lifecycle Action"
    ],
    "detail" : {
      "AutoScalingGroupName" : [
        "${local.global_name}-asg"
      ]
    }
  })

  tags = local.global_tags
}

resource "aws_cloudwatch_event_target" "jenkins_create_target" {
  arn      = replace(var.document_instance_creation_arn, "document/", "automation-definition/")
  rule     = aws_cloudwatch_event_rule.event_instance_creation.id
  role_arn = var.role_trigger_arn
  input_transformer {
    input_paths = {
      "instanceid" : "$.detail.EC2InstanceId",
      "asgName" : "$.detail.AutoScalingGroupName",
      "lifecycleHookName" : "$.detail.LifecycleHookName"
    }
    input_template = <<-INPUT_TEMPLATE_EOF
      {
        "InstanceId":[<instanceid>],
        "LifecycleHookName":[<lifecycleHookName>],
        "AutoScalingGroupName":[<asgName>]
      }
      INPUT_TEMPLATE_EOF
  }
}

resource "aws_cloudwatch_event_rule" "event_instance_removal" {
  name        = "${local.global_name}-instance_removal"
  description = "Capture each AWS Console Sign In"
  event_pattern = jsonencode({
    "source" : [
      "aws.autoscaling"
    ],
    "detail-type" : [
      "EC2 Instance-terminate Lifecycle Action"
    ],
    "detail" : {
      "AutoScalingGroupName" : [
        "${local.global_name}-asg"
      ]
    }
  })
  tags = local.global_tags
}

resource "aws_cloudwatch_event_target" "jenkins_terminate_target" {
  arn      = replace(var.document_instance_removal_arn, "document/", "automation-definition/")
  rule     = aws_cloudwatch_event_rule.event_instance_removal.id
  role_arn = var.role_trigger_arn
  input_transformer {
    input_paths = {
      "instanceid" : "$.detail.EC2InstanceId",
      "asgName" : "$.detail.AutoScalingGroupName",
      "lifecycleHookName" : "$.detail.LifecycleHookName"
    }
    input_template = <<-INPUT_TEMPLATE_EOF
      {
        "InstanceId":[<instanceid>],
        "LifecycleHookName":[<lifecycleHookName>],
        "AutoScalingGroupName":[<asgName>]
      }
      INPUT_TEMPLATE_EOF
  }
}

