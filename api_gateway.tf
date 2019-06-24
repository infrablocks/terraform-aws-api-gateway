resource "aws_api_gateway_rest_api" "api" {
  name        = "api-${var.component}-${var.deployment_identifier}"
  description = "${var.component}-${var.deployment_identifier} REST API"

  endpoint_configuration {
    types = ["${var.endpoint_types}"]
  }
}

//resource "aws_api_gateway_stage" "stage" {
//  stage_name    = "stage-${var.component}-${var.deployment_identifier}"
//  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
//  deployment_id = "${aws_api_gateway_deployment.deployment.id}"
//}


//resource "aws_api_gateway_resource" "resource" {
//  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
//  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
//  path_part   = "root"
//}
//
//resource "aws_api_gateway_method" "method" {
//  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
//  resource_id   = "${aws_api_gateway_resource.resource.id}"
//  http_method   = "GET"
//  authorization = "NONE"
//}
//
//resource "aws_api_gateway_method_settings" "method_settings" {
//  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
//  stage_name  = "${aws_api_gateway_stage.stage.stage_name}"
//  method_path = "${aws_api_gateway_resource.resource.path_part}/${aws_api_gateway_method.method.http_method}"
//
//  settings {
//    metrics_enabled = true
//    logging_level   = "INFO"
//  }
//}


//resource "aws_api_gateway_integration" "integration" {
//  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
//  resource_id = "${aws_api_gateway_resource.resource.id}"
//  http_method = "${aws_api_gateway_method.method.http_method}"
//  type        = "MOCK"
//}


//
//resource "aws_api_gateway_deployment" "deployment" {
//  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
//  stage_name  = "stage-${var.component}-${var.deployment_identifier}"
//  depends_on = ["aws_api_gateway_integration.integration"]
//  }

