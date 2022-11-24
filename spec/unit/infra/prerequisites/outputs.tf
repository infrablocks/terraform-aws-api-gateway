output "domain_name" {
  value = var.domain_name
}
output "public_zone_id" {
  value = var.public_zone_id
}
output "certificate_arn" {
  value = module.certificate.certificate_arn
}

output "api_gateway_rest_api_id" {
  value = aws_api_gateway_rest_api.api.id
}

output "api_gateway_rest_api_root_resource_id" {
  value = aws_api_gateway_rest_api.api.root_resource_id
}
