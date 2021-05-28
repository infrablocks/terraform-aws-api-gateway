resource "aws_acm_certificate" "certificate" {
  domain_name       = each.value
  validation_method = "DNS"
  provider          = aws.certificate

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

resource "aws_route53_record" "cert_validation" {
  name     = aws_acm_certificate.certificate[each.value].domain_validation_options[0].resource_record_name
  type     = aws_acm_certificate.certificate[each.value].domain_validation_options[0].resource_record_type
  zone_id  = var.public_zone_id
  records  = [aws_acm_certificate.certificate[each.value].domain_validation_options[0].resource_record_value]
  ttl      = 60
  provider = aws.certificate
  for_each = var.create_certificate == "yes" ? toset([local.address]) : toset([])
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.certificate[each.value].arn
  validation_record_fqdns = [aws_route53_record.cert_validation[each.value].fqdn]
  provider                = aws.certificate
  for_each                = var.create_certificate == "yes" ? toset([local.address]) : toset([])
}

