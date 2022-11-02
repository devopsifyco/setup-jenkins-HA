variable "global_name" {
  type = string
}

variable "global_tags" {
  type = object({})
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
}

variable "min_size" {
  type        = number
  description = "The minimum size of the autoscale group"
}

variable "desired_capacity" {
  type = number
}

variable "public_key" {
  type = string
}

variable "vpc_zone_identifier" {
  type = list(string)
}

variable "instance_profile" {
  type = string
}

variable "security_groups" {
  type = string
}

variable "target_group_arns" {
  type = string
}