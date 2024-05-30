output "api_gateway_deployment_id" {
  description = "The ID of the API gateway deployment managed by this module."
  value = aws_api_gateway_deployment.deployment.id
}

output "api_gateway_stage_id" {
  description = "The ID of the API gateway stage managed by this module."
  value = aws_api_gateway_stage.stage.id
}

output "api_gateway_stage_arn" {
  description = "The ARN of the API gateway stage managed by this module."
  value = aws_api_gateway_stage.stage.arn
}

output "api_gateway_stage_invoke_url" {
  description = "The invoke URL of the stage managed by this module."
  value = aws_api_gateway_stage.stage.invoke_url
}

output "api_gateway_stage_execution_arn" {
  description = "The execution ARN of the stage managed by this module."
  value = aws_api_gateway_stage.stage.execution_arn
}

output "api_gateway_stage_access_log_log_group_name" {
  description = "The name of the log group created for stage access logging."
  value = aws_cloudwatch_log_group.access_logs["default"].name
}

output "api_gateway_stage_access_log_log_group_arn" {
  description = "The ARN of the log group created for stage access logging."
  value = aws_cloudwatch_log_group.access_logs["default"].arn
}
