resource "aws_api_gateway_deployment" "deployment" {
  description = "Deployment for API: ${var.api_name} of component: ${var.component} and deployment identifier: ${var.deployment_identifier}."

  rest_api_id = var.api_gateway_rest_api_id

  triggers = var.api_gateway_redeployment_triggers

  lifecycle {
    create_before_destroy = true
  }
}
