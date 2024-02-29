
variable "aws_region" {
  type = string
}

variable domain_name {
  default = ""
}

variable alternate_names {
  default = []
}

variable include_wildcard {
  default = true
}
