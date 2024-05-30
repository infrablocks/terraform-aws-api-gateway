variable "region" {}

variable "component" {}
variable "deployment_identifier" {}

variable "api_gateway_rest_api_id" {}
variable "api_gateway_stage_name" {}
variable "api_gateway_redeployment_triggers" {
  type = map(string)
}
variable "api_gateway_stage_access_logging_log_format" {
  default = null
}
variable "api_gateway_stage_access_logging_log_group_arn" {
  default = null
}

variable "enable_api_gateway_stage_xray_tracing" {
  type = bool
  default = null
}
variable "enable_api_gateway_stage_access_logging" {
  type = bool
  default = null
}
variable "include_api_gateway_stage_access_log_log_group" {
  type = bool
  default = null
}

variable "tags" {
  type    = map(string)
  default = null
}
