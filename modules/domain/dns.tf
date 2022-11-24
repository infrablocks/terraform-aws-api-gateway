locals {
  zones = {
    for record in var.dns.records : record.zone_id => record
  }
}
resource "aws_route53_record" "domain" {
  for_each = local.zones

  zone_id = each.key
  name    = aws_api_gateway_domain_name.domain_name.domain_name
  type    = "A"

  alias {
    evaluate_target_health = true
    name                   = var.api_gateway_rest_api_endpoint_type == "EDGE" ? aws_api_gateway_domain_name.domain_name.cloudfront_domain_name : aws_api_gateway_domain_name.domain_name.regional_domain_name
    zone_id                = var.api_gateway_rest_api_endpoint_type == "EDGE" ? aws_api_gateway_domain_name.domain_name.cloudfront_zone_id : aws_api_gateway_domain_name.domain_name.regional_zone_id
  }
}
