locals {
  bucket_name = "${replace(var.resizer_host_name,".","-")}--files"
}

locals {
  domain_split = split(".",var.resizer_host_name)
  domain_split_length = length(local.domain_split)
  domain_name = local.domain_split_length > 1 ? "${local.domain_split[local.domain_split_length - 2]}.${local.domain_split[local.domain_split_length - 1]}" : ""
  certificate_domain = length(var.certificate_domain_name) > 0 ? var.certificate_domain_name : local.domain_name
}

# create a Route53 for the domain if needed
resource "aws_route53_zone" "main" {
  count = var.create_route53_zone ? 1 : 0
  name = local.domain_name
}

# create a wildcard certificate
module certificate {
  count = var.create_certificate ? 1 : 0
  source = "../../resources/certificate"
  aws_region = var.aws_region
  domain_name = local.certificate_domain
}

resource "aws_s3_bucket" "files" {
  bucket = local.bucket_name
  force_destroy = true
}

module "resizer" {
  depends_on = [aws_s3_bucket.files, module.certificate, aws_route53_zone.main]
  source = "../../modules/resizer"

  aws_region = var.aws_region
  service = "ckhtech"
  host_name = var.resizer_host_name
  sizes_by_name = var.resizer_sizes
  files_bucket = aws_s3_bucket.files.bucket
}

resource aws_s3_object dog {
  bucket = module.resizer.files_bucket
  key = "${module.resizer.source_directory}/dog/${module.resizer.original_directory}/dog.jpeg"
  source = "images/dog.jpeg"
}

resource aws_s3_object possum {
  bucket = module.resizer.files_bucket
  key = "${module.resizer.source_directory}/possum/${module.resizer.original_directory}/possum.jpeg"
  source = "images/possum.jpeg"
}
