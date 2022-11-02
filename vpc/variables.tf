variable "global_name" {
  type = string
}

variable "global_tags" {
  type = object({})
}

variable "cidr" {
  type    = string
}

variable "azs" {
  type    = list(string)
}

variable "public_subnets" {
  type    = list(string)
}

variable "private_subnets" {
  type    = list(string)
}

variable "egress_rules" {
  type    = list(string)
}

variable "ingress_with_cidr_blocks" {
  default = []
}