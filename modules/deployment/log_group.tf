resource "aws_cloudwatch_log_group" "access_logs" {
  for_each = var.include_api_gateway_stage_access_log_log_group ? toset(["default"]) : toset([])
  name = "/${var.component}/${var.deployment_identifier}/api-gateway/${var.api_name}/${var.api_gateway_stage_name}"
}
