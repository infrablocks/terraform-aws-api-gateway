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
