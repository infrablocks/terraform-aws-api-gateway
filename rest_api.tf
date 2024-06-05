resource "aws_api_gateway_rest_api" "api" {
  name        = "api-${var.component}-${var.deployment_identifier}-${var.api_name}"
  description = "REST API: ${var.api_name} for component: ${var.component} and deployment identifier: ${var.deployment_identifier}."

  endpoint_configuration {
    types = [var.api_gateway_rest_api_endpoint_type]
    vpc_endpoint_ids = var.api_gateway_rest_api_endpoint_type == "PRIVATE" ? toset(var.api_gateway_rest_api_vpc_endpoint_ids) : null
  }
}
