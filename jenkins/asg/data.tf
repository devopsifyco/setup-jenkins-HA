# -------------------------------------------------------
# AWS General Information
# -------------------------------------------------------
data "aws_availability_zones" "available" {
  state = "available"
}

# -------------------------------------------------------
# AMI Information
# -------------------------------------------------------
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["jenkins-ami-*"]
  }

  owners = ["self"]
}

data "aws_iam_instance_profile" "linux_profile" {
  name = var.instance_profile
}
