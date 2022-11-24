variable "region" {
  description = "The region into which to deploy the API gateway REST API."
}

variable "component" {
  description = "The component for which the API gateway REST API is being created."
}

variable "deployment_identifier" {
  description = "An identifier for this instantiation."
}

variable "api_gateway_rest_api_endpoint_type" {
  description = "The type of the endpoints in this REST API. Valid values: EDGE, REGIONAL or PRIVATE. Defaults to EDGE."
  default     = "EDGE"
  nullable    = false
}

variable "api_gateway_rest_api_source_policy_document" {
  description = "A source policy document for the policy associated with the REST API. Only required if `include_api_gateway_rest_api_policy` is true."
  default     = ""
  nullable    = false
}

variable "include_api_gateway_rest_api_policy" {
  description = "Whether or not to include an IAM policy on the REST API. Defaults to false."
  default     = false
  nullable    = false
}
