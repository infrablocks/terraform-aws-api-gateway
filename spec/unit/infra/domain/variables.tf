variable "region" {}

variable "component" {}
variable "deployment_identifier" {}

variable "api_gateway_rest_api_id" {}
variable "api_gateway_rest_api_endpoint_type" {
  default = null
}
variable "api_gateway_stage_name" {}
variable "api_gateway_domain_name" {}
variable "api_gateway_domain_name_certificate_arn" {}
variable "api_gateway_domain_name_security_policy" {
  default = null
}
variable "api_gateway_domain_name_base_path" {
  default = null
}

variable "dns" {
  type = object({
    records : optional(list(object({ zone_id : string })))
  })
  default = null
}

variable "tags" {
  type        = map(string)
  default     = null
}
