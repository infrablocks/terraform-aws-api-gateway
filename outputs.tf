locals {
  redeployment_triggers = {
    rest_api = sha256(jsonencode(aws_api_gateway_rest_api.api))
    policy = try(sha256(jsonencode(aws_api_gateway_rest_api_policy.api_policy["default"])), "")
  }
}

output "api_gateway_rest_api_name" {
  description = "The name of the created API Gateway REST API."
  value       = aws_api_gateway_rest_api.api.name
}

output "api_gateway_rest_api_id" {
  description = "The ID of the created API Gateway REST API."
  value       = aws_api_gateway_rest_api.api.id
}

output "api_gateway_rest_api_root_resource_id" {
  description = "The resource ID of the REST API's root"
  value       = aws_api_gateway_rest_api.api.root_resource_id
}

output "api_gateway_redeployment_triggers" {
  description = "A map of redeployment triggers for use in the `infrablocks/api-gateway/aws//modules/deployment` module such that a redeployment will be triggered on change."
  value = local.redeployment_triggers
}
