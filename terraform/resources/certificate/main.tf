locals {
  domain_split = split(".",var.domain_name)
  domain_split_length = length(local.domain_split)
  domain_name_top = "${local.domain_split[local.domain_split_length - 2]}.${local.domain_split[local.domain_split_length - 1]}"
}

data aws_route53_zone main {
  name = local.domain_name_top
}

resource "aws_acm_certificate" "main" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  subject_alternative_names = concat(
    [var.domain_name],
    var.include_wildcard ? ["*.${var.domain_name}"] : [],
    var.alternate_names
  )
}

resource "aws_route53_record" "main" {
  for_each = {
  for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
    name   = dvo.resource_record_name
    record = dvo.resource_record_value
    type   = dvo.resource_record_type
  }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.main : record.fqdn]
}