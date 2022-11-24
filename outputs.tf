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
