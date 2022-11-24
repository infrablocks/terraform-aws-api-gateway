output "api_gateway_domain_name_cloudfront_domain_name" {
  description = "The CloudFront domain name of the domain endpoint of the API gateway for the domain. Populated when endpoint type is \"EDGE\"."
  value = aws_api_gateway_domain_name.domain_name.cloudfront_domain_name
}
output "api_gateway_domain_name_cloudfront_zone_id" {
  description = "The CloudFront zone ID of the domain endpoint of the API gateway for the domain. Populated when endpoint type is \"EDGE\"."
  value = aws_api_gateway_domain_name.domain_name.cloudfront_zone_id
}
output "api_gateway_domain_name_regional_domain_name" {
  description = "The regional domain name of the domain endpoint of the API gateway for the domain. Populated when endpoint type is \"REGIONAL\"."
  value = aws_api_gateway_domain_name.domain_name.regional_domain_name
}
output "api_gateway_domain_name_regional_zone_id" {
  description = "The regional zone ID of the domain endpoint of the API gateway for the domain. Populated when endpoint type is \"REGIONAL\"."
  value = aws_api_gateway_domain_name.domain_name.regional_zone_id
}
