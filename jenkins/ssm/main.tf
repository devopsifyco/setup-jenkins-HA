resource "aws_ssm_document" "instance_creation" {
  name          = "${local.global_name}-instances_creation"
  document_type = "Automation"
  content = templatefile("${path.module}/ssm-instance-creation.yaml", {
    automationAssumeRole   = var.role_execute_arn
    CloudWatchLogGroupName = var.instance_creation_logs
    MountTargetDns         = var.mount_target_dns
    MountPoint             = "/jenkins-data"
  })
  document_format = "YAML"
  tags            = local.global_tags
}

resource "aws_ssm_document" "instance_removal" {
  name          = "${local.global_name}-instances_removal"
  document_type = "Automation"
  content = templatefile("${path.module}/ssm-instance-removal.yaml", {
    automationAssumeRole   = var.role_execute_arn
    CloudWatchLogGroupName = var.instance_removal_logs

  })
  document_format = "YAML"
  tags            = local.global_tags
}
