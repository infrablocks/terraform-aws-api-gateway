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
variable "api_gateway_stage_access_logging_log_format" {
  description = "The log format to use for access logging on the API gateway stage."
  type = string
  default = "{\"accountId\": \"$context.accountId\", \"apiId\": \"$context.apiId\", \"authenticate.error\": \"$context.authenticate.error\", \"authenticate.latency\": \"$context.authenticate.latency\", \"authenticate.status\": \"$context.authenticate.status\", \"authorize.error\": \"$context.authorize.error\", \"authorize.latency\": \"$context.authorize.latency\", \"authorize.status\": \"$context.authorize.status\", \"authorizer.error\": \"$context.authorizer.error\", \"authorizer.integrationLatency\": \"$context.authorizer.integrationLatency\", \"authorizer.integrationStatus\": \"$context.authorizer.integrationStatus\", \"authorizer.latency\": \"$context.authorizer.latency\", \"authorizer.principalId\": \"$context.authorizer.principalId\", \"authorizer.requestId\": \"$context.authorizer.requestId\", \"authorizer.status\": \"$context.authorizer.status\", \"awsEndpointRequestId\": \"$context.awsEndpointRequestId\", \"customDomain.basePathMatched\": \"$context.customDomain.basePathMatched\", \"deploymentId\": \"$context.deploymentId\", \"domainName\": \"$context.domainName\", \"domainPrefix\": \"$context.domainPrefix\", \"endpointType\": \"$context.endpointType\", \"error.message\": \"$context.error.message\", \"error.messageString\": \"$context.error.messageString\", \"error.responseType\": \"$context.error.responseType\", \"error.validationErrorString\": \"$context.error.validationErrorString\", \"extendedRequestId\": \"$context.extendedRequestId\", \"httpMethod\": \"$context.httpMethod\", \"identity.accountId\": \"$context.identity.accountId\", \"identity.apiKey\": \"$context.identity.apiKey\", \"identity.apiKeyId\": \"$context.identity.apiKeyId\", \"identity.caller\": \"$context.identity.caller\", \"identity.cognitoAuthenticationProvider\": \"$context.identity.cognitoAuthenticationProvider\", \"identity.cognitoAuthenticationType\": \"$context.identity.cognitoAuthenticationType\", \"identity.cognitoIdentityId\": \"$context.identity.cognitoIdentityId\", \"identity.cognitoIdentityPoolId\": \"$context.identity.cognitoIdentityPoolId\", \"identity.principalOrgId\": \"$context.identity.principalOrgId\", \"identity.sourceIp\": \"$context.identity.sourceIp\", \"identity.clientCert.clientCertPem\": \"$context.identity.clientCert.clientCertPem\", \"identity.clientCert.subjectDN\": \"$context.identity.clientCert.subjectDN\", \"identity.clientCert.issuerDN\": \"$context.identity.clientCert.issuerDN\", \"identity.clientCert.serialNumber\": \"$context.identity.clientCert.serialNumber\", \"identity.clientCert.validity.notBefore\": \"$context.identity.clientCert.validity.notBefore\", \"identity.clientCert.validity.notAfter\": \"$context.identity.clientCert.validity.notAfter\", \"identity.vpcId\": \"$context.identity.vpcId\", \"identity.vpceId\": \"$context.identity.vpceId\", \"identity.user\": \"$context.identity.user\", \"identity.userAgent\": \"$context.identity.userAgent\", \"identity.userArn\": \"$context.identity.userArn\", \"integration.error\": \"$context.integration.error\", \"integration.integrationStatus\": \"$context.integration.integrationStatus\", \"integration.latency\": \"$context.integration.latency\", \"integration.requestId\": \"$context.integration.requestId\", \"integration.status\": \"$context.integration.status\", \"integrationLatency\": \"$context.integrationLatency\", \"integrationStatus\": \"$context.integrationStatus\", \"isCanaryRequest\": \"$context.isCanaryRequest\", \"path\": \"$context.path\", \"protocol\": \"$context.protocol\", \"requestId\": \"$context.requestId\", \"responseLength\": \"$context.responseLength\", \"responseLatency\": \"$context.responseLatency\", \"responseOverride.status\": \"$context.responseOverride.status\", \"requestTime\": \"$context.requestTime\", \"requestTimeEpoch\": \"$context.requestTimeEpoch\", \"resourceId\": \"$context.resourceId\", \"resourcePath\": \"$context.resourcePath\", \"stage\": \"$context.stage\", \"status\": \"$context.status\", \"waf.error\": \"$context.waf.error\", \"waf.latency\": \"$context.waf.latency\", \"waf.status\": \"$context.waf.status\", \"wafResponseCode\": \"$context.wafResponseCode\", \"webaclArn\": \"$context.webaclArn\", \"xrayTraceId\": \"$context.xrayTraceId\"}"
  nullable = false
}
variable "api_gateway_stage_access_logging_log_group_arn" {
  description = "The ARN of the CloudWatch log group to use for access logging. Required when `include_api_gateway_stage_access_log_log_group` is `false`."
  type = string
  default = null
}

variable "enable_api_gateway_stage_xray_tracing" {
  description = "Whether tracing using AWS X-Ray is enabled on the API gateway stage."
  type = bool
  default = false
  nullable = false
}
variable "enable_api_gateway_stage_access_logging" {
  description = "Whether to enable access logging on the API gateway stage."
  type = bool
  default = false
  nullable = false
}
variable "include_api_gateway_stage_access_log_log_group" {
  description = "Whether to create a log group for access logging on the API gateway stage."
  type = bool
  default = true
  nullable = false
}

variable "tags" {
  description = "A map of tags to add to created infrastructure components."
  type        = map(string)
  default     = {}
  nullable    = false
}
