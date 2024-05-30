resource "aws_api_gateway_stage" "stage" {
  description = "Stage: ${var.api_gateway_stage_name} for component: ${var.component} and deployment identifier: ${var.deployment_identifier}."

  rest_api_id = var.api_gateway_rest_api_id
  stage_name = var.api_gateway_stage_name

  deployment_id = aws_api_gateway_deployment.deployment.id

  xray_tracing_enabled = var.enable_xray_tracing

  tags = merge(local.resolved_tags, {
    Stage: var.api_gateway_stage_name
  })
}
