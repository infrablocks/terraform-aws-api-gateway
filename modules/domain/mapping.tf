resource "aws_api_gateway_base_path_mapping" "mapping" {
  api_id      = var.api_gateway_rest_api_id
  stage_name  = var.api_gateway_stage_name
  domain_name = aws_api_gateway_domain_name.domain_name.domain_name
  base_path   = var.api_gateway_domain_name_base_path
}
