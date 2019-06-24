resource "aws_api_gateway_domain_name" "domain_name_resource" {
  certificate_arn = "${aws_acm_certificate_validation.cert.certificate_arn}"
  domain_name     = "${var.subdomain}.${var.domain_name}"
}

resource "aws_route53_record" "api_public" {
  zone_id = "${var.public_zone_id}"
  name    = "${aws_api_gateway_domain_name.domain_name_resource.domain_name}"
  type    = "A"

  alias {
    evaluate_target_health = true
    name                   = "${aws_api_gateway_domain_name.domain_name_resource.cloudfront_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.domain_name_resource.cloudfront_zone_id}"
  }
}
