resource "aws_api_gateway_rest_api" "api" {
  name        = "api-${var.component}-${var.deployment_identifier}"
  description = "REST API for component: ${var.component} and deployment identifier: ${var.deployment_identifier}."

  endpoint_configuration {
    types = [var.api_gateway_rest_api_endpoint_type]
  }
}
