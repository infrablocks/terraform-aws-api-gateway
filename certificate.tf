locals {
  domain_validation_records = {
    for domain_validation in aws_acm_certificate.certificate[local.address].domain_validation_options:
      domain_validation.domain_name => {
        record_name: domain_validation.resource_record_name,
        record_type: domain_validation.resource_record_type,
        record_value: domain_validation.resource_record_value,
      }
  }
}

resource "aws_acm_certificate" "certificate" {
  domain_name = each.value

  validation_method = "DNS"

  tags = {
    Name                 = "cert-${each.value}"
    Component            = var.component
    DeploymentIdentifier = var.deployment_identifier
  }

  lifecycle {
    create_before_destroy = true
  }

  for_each = var.create_certificate == "yes" ? toset([local.address]) : toset([])
}

resource "aws_route53_record" "domain_validation" {
  for_each = var.create_certificate == "yes" ? local.domain_validation_records : {}

  zone_id = var.public_zone_id

  name = each.value.record_name
  type = each.value.record_type
  ttl = 60
  records = [
    each.value.record_value
  ]

  allow_overwrite = true

  depends_on = [
    aws_acm_certificate.certificate
  ]
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn = aws_acm_certificate.certificate[local.address].arn
  validation_record_fqdns = [for record in aws_route53_record.domain_validation : record.fqdn]
  for_each                = var.create_certificate == "yes" ? toset([local.address]) : toset([])
}
