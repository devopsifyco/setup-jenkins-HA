variable "global_name" {
  type = string
}

variable "global_tags" {
  type = object({})
}

variable "instance_type" {
  type = string
}

variable "max_size" {
  type = string
}

variable "min_size" {
  type = string
}

variable "desired_capacity" {
  type = string
}

variable "security_groups" {
  type = string
}

variable "vpc_zone_identifier" {
  type = list(string)
}

variable "wait_for_capacity_timeout" {
  type = string
}

variable "health_check_type" {
  type = string
}

variable "public_key" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "region" {
  type = string
}