variable "global_name" {
  type = string
}

variable "global_tags" {
  type = object({})
}

variable "document_instance_creation_arn" {
  type = string
}

variable "document_instance_removal_arn" {
  type = string
}