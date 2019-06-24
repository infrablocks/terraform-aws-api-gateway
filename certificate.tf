resource "aws_acm_certificate" "certificate" {
  domain_name       = "${var.subdomain}.${var.domain_name}"
  validation_method = "DNS"
  provider          = "aws.useast1"

  tags = {
    Name                 = "cert-${var.subdomain}.${var.domain_name}"
    Component            = "${var.component}"
    DeploymentIdentifier = "${var.deployment_identifier}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  name     = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name}"
  type     = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type}"
  zone_id  = "${var.public_zone_id}"
  records  = ["${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value}"]
  ttl      = 60
  provider = "aws.useast1"
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.certificate.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
  provider                = "aws.useast1"
}
