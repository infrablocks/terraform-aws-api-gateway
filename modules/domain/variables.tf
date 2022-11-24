variable "region" {
  description = "The region into which to deploy the API gateway deployment."
}

variable "component" {
  description = "The component for which the API gateway deployment is being created."
}
variable "deployment_identifier" {
  description = "An identifier for this instantiation."
}

variable "api_gateway_rest_api_id" {
  description = "The ID of the API gateway REST API for which this domain is being managed."
}
variable "api_gateway_rest_api_endpoint_type" {
  description = "The type of the endpoints in this REST API. Valid values: EDGE, REGIONAL or PRIVATE. Defaults to EDGE."
  default     = "EDGE"
  nullable    = false
}
variable "api_gateway_stage_name" {
  description = "The stage name for the API gateway stage created for this deployment."
}
variable "api_gateway_domain_name" {
  description = "The domain name to use for the API gateway."
}
variable "api_gateway_domain_name_certificate_arn" {
  description = "The ARN of a certificate to associate with the API gateway for this domain."
}
variable "api_gateway_domain_name_security_policy" {
  description = "The security policy to use on the API gateway for this domain."
  default = "TLS_1_2"
  nullable = false
}
variable "api_gateway_domain_name_base_path" {
  description = "The base path at which to expose the API managed by the API gateway for this domain."
  default = null
}

variable "dns" {
  description = "Details of the DNS records to create pointing at the API gateway for this domain name."
  type = object({
    records: optional(list(object({zone_id: string})))
  })
  default = {
    records: []
  }
  nullable = false
}

variable "tags" {
  description = "AWS tags to use on created infrastructure components."
  type        = map(string)
  default     = {}
  nullable    = false
}
