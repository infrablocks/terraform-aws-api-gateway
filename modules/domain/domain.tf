// noinspection ConflictingProperties
resource "aws_api_gateway_domain_name" "domain_name" {
  domain_name              = var.api_gateway_domain_name
  certificate_arn          = var.api_gateway_rest_api_endpoint_type == "EDGE" ? var.api_gateway_domain_name_certificate_arn : null
  regional_certificate_arn = var.api_gateway_rest_api_endpoint_type == "REGIONAL" ? var.api_gateway_domain_name_certificate_arn : null

  security_policy = var.api_gateway_domain_name_security_policy

  endpoint_configuration {
    types = [var.api_gateway_rest_api_endpoint_type]
  }
}
