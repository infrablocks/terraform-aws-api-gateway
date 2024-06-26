variable "region" {}

variable "component" {}
variable "deployment_identifier" {}
variable "api_name" {
  default = null
}

variable "api_gateway_rest_api_endpoint_type" {
  default = null
}
variable "api_gateway_rest_api_vpc_endpoint_ids" {
  type = list(string)
  default = null
}

variable "api_gateway_rest_api_source_policy_document" {
  default = null
}

variable "include_api_gateway_rest_api_policy" {
  default = null
}
