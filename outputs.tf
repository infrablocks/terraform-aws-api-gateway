output "name" {
  description = "The name of the created API Gateway."
  value       = "${aws_api_gateway_rest_api.api.name}"
}

output "id" {
  description = "The id of the created API Gateway."
  value       = "${aws_api_gateway_rest_api.api.id}"
}

output "address" {
  description = "Address of the API Gateway"
  value       = "https://${aws_acm_certificate.certificate.domain_name}"
}
