output "api_gateway_deployment_id" {
  value = module.deployment.api_gateway_deployment_id
}

output "api_gateway_stage_id" {
  value = module.deployment.api_gateway_stage_id
}

output "api_gateway_stage_arn" {
  value = module.deployment.api_gateway_stage_arn
}

output "api_gateway_stage_invoke_url" {
  value = module.deployment.api_gateway_stage_invoke_url
}

output "api_gateway_stage_execution_arn" {
  value = module.deployment.api_gateway_stage_execution_arn
}
