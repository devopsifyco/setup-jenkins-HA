variable "global_name" {
  type = string
}

variable "global_tags" {
  type = object({})
}

variable "subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}