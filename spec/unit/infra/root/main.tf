data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "api_gateway" {
  source = "../../../.."

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  api_gateway_rest_api_endpoint_type = var.api_gateway_rest_api_endpoint_type

  api_gateway_rest_api_source_policy_document = var.api_gateway_rest_api_source_policy_document

  include_api_gateway_rest_api_policy = var.include_api_gateway_rest_api_policy
}
