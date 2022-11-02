variable "region" {
  type        = string
  description = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "Instance type to launch"
}

variable "health_check_type" {
  type        = string
  description = "Controls how health checking is downe. Valid values are `EC2` or `ELB`"
}

variable "wait_for_capacity_timeout" {
  type        = string
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior"
}

variable "max_size" {
  type        = number
  description = "The maximum size of the autoscale group"
  default     = "0"
}

variable "min_size" {
  type        = number
  description = "The minimum size of the autoscale group"
  default     = "0"
}

variable "desired_capacity" {
  type    = number
  default = "0"
}

variable "public_key" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "egress_rules" {
  type = list(string)
}

variable "cidr" {
  type = string
}

variable "ingress_with_cidr_blocks" {
  default = []
}