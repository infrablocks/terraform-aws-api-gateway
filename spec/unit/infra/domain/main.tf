data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "domain" {
  source = "../../../../modules/domain"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  api_gateway_rest_api_id = var.api_gateway_rest_api_id
  api_gateway_rest_api_endpoint_type = var.api_gateway_rest_api_endpoint_type
  api_gateway_stage_name = var.api_gateway_stage_name
  api_gateway_domain_name = lower(var.api_gateway_domain_name)
  api_gateway_domain_name_certificate_arn = var.api_gateway_domain_name_certificate_arn
  api_gateway_domain_name_base_path = var.api_gateway_domain_name_base_path
  api_gateway_domain_name_security_policy = var.api_gateway_domain_name_security_policy

  dns = var.dns

  tags = var.tags
}
