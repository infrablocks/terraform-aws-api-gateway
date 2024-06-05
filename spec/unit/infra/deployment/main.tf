data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "deployment" {
  source = "../../../../modules/deployment"

  region = var.region

  component             = var.component
  deployment_identifier = var.deployment_identifier
  api_name              = var.api_name

  api_gateway_rest_api_id           = var.api_gateway_rest_api_id
  api_gateway_stage_name            = var.api_gateway_stage_name
  api_gateway_redeployment_triggers = var.api_gateway_redeployment_triggers

  api_gateway_stage_access_logging_log_format    = var.api_gateway_stage_access_logging_log_format
  api_gateway_stage_access_logging_log_group_arn = var.api_gateway_stage_access_logging_log_group_arn

  include_api_gateway_stage_access_log_log_group = var.include_api_gateway_stage_access_log_log_group

  enable_api_gateway_stage_xray_tracing   = var.enable_api_gateway_stage_xray_tracing
  enable_api_gateway_stage_access_logging = var.enable_api_gateway_stage_access_logging

  tags = var.tags
}
