output "domain_name" {
  value = var.domain_name
}
output "public_zone_id" {
  value = var.public_zone_id
}
output "certificate_arn" {
  value = module.certificate.certificate_arn
}

output "api_gateway_rest_api_name" {
  value = module.api_gateway.api_gateway_rest_api_name
}

output "api_gateway_rest_api_id" {
  value = module.api_gateway.api_gateway_rest_api_id
}

output "api_gateway_rest_api_root_resource_id" {
  value = module.api_gateway.api_gateway_rest_api_root_resource_id
}

output "api_gateway_domain_name_cloudfront_domain_name" {
  value = module.domain.api_gateway_domain_name_cloudfront_domain_name
}
output "api_gateway_domain_name_cloudfront_zone_id" {
  value = module.domain.api_gateway_domain_name_cloudfront_zone_id
}
output "api_gateway_domain_name_regional_domain_name" {
  value = module.domain.api_gateway_domain_name_regional_domain_name
}
output "api_gateway_domain_name_regional_zone_id" {
  value = module.domain.api_gateway_domain_name_regional_zone_id
}

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
