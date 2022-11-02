# -------------------------------------------------------
# Polices
# -------------------------------------------------------
data "aws_iam_policy_document" "instance_creation_removal_policy" {
  statement {
    sid = "BasePolicy"
    actions = [
      "ssm:*",
      "s3:*",
      "autoscaling:CompleteLifecycleAction",
      "autoscaling:DescribeAutoScalingGroups",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "logs:DescribeLogGroups",
      "ec2:*",
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}
data "aws_iam_policy_document" "base_policy" {
  statement {
    sid = "BasePolicy"
    actions = [
      "ec2:DescribeVolumes",
      "ec2:DescribeTags",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "logs:DescribeLogGroups",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue",
      "kms:*",
      "cloudwatch:*"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}



