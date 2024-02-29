variable "aws_region" { type = string }

variable "service" {
  type = string
}

variable name {
  default = "resizer"
}

variable files_bucket {
  type = string
}

#variable code_bucket {
#  default = ""
#}

#variable code_path {
#  default = "code"
#}

variable host_name {
  default = ""
}

# optional, can use host_name
variable certificate_domain_name {
  default = ""
}

variable original_formats {
  default = ["png", "jpeg", "jpg", "webp", "tiff", "gif", "heic"]
  description = "valid formats that can be converted from"
}

variable output_formats {
  default = ["jpeg", "webp"]
  description = "valid formats for converting to"
}

variable sizes_by_name {
  default = {
    large = {
      width = 1024
      height = 1024
    }
    medium = {
      width = 512
      height = 512
    }
    small = {
      width = 256
      height = 256
    }
    thumb = {
      width = 128
      height = 128
    }
    default = {
      scale = false
    }
  }
}

variable skip_cloudfront {
  default = false
}

variable cloudfront_cors_origins {
  default = ["*"]
}

variable original_directory {
  default = "original"
}

# look in ${source_direcotry}/UUID/${original_directory}/ for source uploads
# set to files/images to use same location as destination
variable source_directory {
  default = "source/images"
}

# query and store conversions in ${destination_directory}/UUID/
variable destination_directory {
  default = "files/images"
}

variable encrypt_bucket {
  default = false # adds encryption to the bucket, the KMS key created can be used by cloudfront as well
}

