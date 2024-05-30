data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "deployment" {
  source = "../../../../modules/deployment"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  api_gateway_rest_api_id = var.api_gateway_rest_api_id
  api_gateway_stage_name = var.api_gateway_stage_name
  api_gateway_redeployment_triggers = var.api_gateway_redeployment_triggers

  enable_xray_tracing = var.enable_xray_tracing

  tags = var.tags
}
