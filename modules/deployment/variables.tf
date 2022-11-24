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
  description = "The ID of the API gateway REST API for which this deployment is being managed."
}
variable "api_gateway_stage_name" {
  description = "The stage name for the API gateway stage created for this deployment."
}
variable "api_gateway_redeployment_triggers" {
  description = "A map of key value pairs such that when any value changes, redeployment of the API gateway stage is triggered."
  type = map(string)
}

variable "tags" {
  description = "A map of tags to add to created infrastructure components."
  type        = map(string)
  default     = {}
  nullable    = false
}
