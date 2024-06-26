resource "aws_api_gateway_rest_api" "api" {
  name          = "provided-rest-api-${var.component}-${var.deployment_identifier}"
  description   = "Provided REST API for component: \"${var.component}\" and deployment identifier: \"${var.deployment_identifier}\"."

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_cloudwatch_log_group" "test" {
  name = "/${var.component}/${var.deployment_identifier}/api-gateway/testing"
}

module "certificate" {
  source  = "infrablocks/acm-certificate/aws"
  version = "1.1.0"

  domain_name = var.domain_name
  domain_zone_id = var.public_zone_id

  subject_alternative_names = []
  subject_alternative_name_zone_id = var.public_zone_id

  providers = {
    aws.certificate = aws.us_east_1
    aws.domain_validation = aws.us_east_1
    aws.san_validation = aws.us_east_1
  }
}
