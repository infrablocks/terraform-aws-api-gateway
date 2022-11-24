variable "region" {}

variable "component" {}
variable "deployment_identifier" {}

variable "api_gateway_rest_api_id" {}
variable "api_gateway_stage_name" {}
variable "api_gateway_redeployment_triggers" {
  type = map(string)
}

variable "tags" {
  type    = map(string)
  default = null
}
