variable "global_name" {
  type = string
}

variable "global_tags" {
  type = object({})
}

variable "instance_removal_logs" {
  type = string
}

variable "instance_creation_logs" {
  type = string
}

variable "role_execute_arn" {
  type = string
}

variable "mount_target_dns" {
  type = string
}