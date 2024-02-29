variable "aws_region" {
  default = "us-east-1"
}

variable "resizer_host_name" {
  type = string
  description = "Host name for images e.g. images.mydomain.com"
}

variable "create_route53_zone" {
  default = false
  description = "Creates a Route53 Zone. This is needed if a zone does not yet exist."
}

variable "create_certificate" {
  default = false
  description = "If needed, a certificate can be created for resizer_host_name. Otherwise, looks for an existing certificate."
}

variable "certificate_domain_name" {
  default = ""
  description = "Optional - looks for a certificate with this domain instead of using the root of resizer_host_name"
}

variable resizer_sizes {
  description = "Mapping of all valid output sizes"
  default = {
    portrait = {
      width  = 768
      height = 1024
    }
    landscape = {
      width  = 1024
      height = 768
    }
    large = {
      width  = 1024
      height = 1024
    }
    medium = {
      width  = 512
      height = 512
    }
    small = {
      width  = 256
      height = 256
    }
    thumb = {
      width  = 128
      height = 128
    }
    default = {
      scale = false # doesn't resize just converts to the desired format
    }
  }
}
