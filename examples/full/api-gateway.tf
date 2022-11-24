locals {
  stage_name = "default"
  tags = {
    Important: "tag"
  }
}
module "api_gateway" {
  source = "../../"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = module.api_gateway.api_gateway_rest_api_id
  parent_id   = module.api_gateway.api_gateway_rest_api_root_resource_id
  path_part   = "resource"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = module.api_gateway.api_gateway_rest_api_id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id          = module.api_gateway.api_gateway_rest_api_id
  resource_id          = aws_api_gateway_resource.resource.id
  http_method          = aws_api_gateway_method.method.http_method
  type                 = "MOCK"
}

module "deployment" {
  source = "../../modules/deployment"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  api_gateway_rest_api_id = module.api_gateway.api_gateway_rest_api_id
  api_gateway_stage_name = local.stage_name
  api_gateway_redeployment_triggers = {
    resource_id: aws_api_gateway_resource.resource.id,
    method_id: aws_api_gateway_method.method.id,
    integration_id: aws_api_gateway_integration.integration.id
  }

  tags = local.tags

  depends_on = [
    aws_api_gateway_resource.resource,
    aws_api_gateway_method.method,
    aws_api_gateway_integration.integration
  ]
}

module "domain" {
  source = "../../modules/domain"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  api_gateway_rest_api_id = module.api_gateway.api_gateway_rest_api_id
  api_gateway_stage_name = local.stage_name
  api_gateway_domain_name = var.domain_name
  api_gateway_domain_name_certificate_arn = module.certificate.certificate_arn

  dns = {
    records: [
      {
        zone_id: var.public_zone_id
      }
    ]
  }

  tags = local.tags

  depends_on = [
    module.api_gateway,
    module.deployment,
    module.certificate
  ]
}
