resource "aws_api_gateway_rest_api" "api" {
  name        = "api-${var.component}-${var.deployment_identifier}"
  description = "${var.component}-${var.deployment_identifier} REST API"

  endpoint_configuration {
    types = [var.endpoint_types]
  }
}
