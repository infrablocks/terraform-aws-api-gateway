variable "region" {}

variable "component" {}
variable "deployment_identifier" {}

variable "api_gateway_rest_api_endpoint_type" {
  default = null
}

variable "api_gateway_rest_api_source_policy_document" {
  default = null
}

variable "include_api_gateway_rest_api_policy" {
  default = null
}
