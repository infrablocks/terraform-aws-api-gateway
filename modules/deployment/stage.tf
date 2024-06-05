resource "aws_api_gateway_stage" "stage" {
  description = "Stage: ${var.api_gateway_stage_name} for API: ${var.api_name} of component: ${var.component} and deployment identifier: ${var.deployment_identifier}."

  rest_api_id = var.api_gateway_rest_api_id
  stage_name = var.api_gateway_stage_name

  deployment_id = aws_api_gateway_deployment.deployment.id

  xray_tracing_enabled = var.enable_api_gateway_stage_xray_tracing

  dynamic "access_log_settings" {
    for_each = var.enable_api_gateway_stage_access_logging ? toset(["default"]) : toset([])
    content {
      format = var.api_gateway_stage_access_logging_log_format
      destination_arn = coalesce(var.api_gateway_stage_access_logging_log_group_arn, aws_cloudwatch_log_group.access_logs["default"].arn)
    }
  }

  tags = merge(local.resolved_tags, {
    ApiName: var.api_name,
    Stage: var.api_gateway_stage_name,
  })
}
