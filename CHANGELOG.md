## Unreleased

IMPROVEMENTS

* The `deployment` submodule now supports enabling X-Ray tracing using the
  `enable_api_gateway_stage_xray_tracing` variable. Tracing is disabled by 
  default.
* The `deployment` submodule now supports enabling access logging via the
  `enable_api_gateway_stage_access_logging` variable. By default, all loggable
  attributes are logged and a log group is created to contain the logs. The
  `api_gateway_stage_access_logging_log_format` variable allows the log format
  to be overridden. The `api_gateway_stage_access_logging_log_group_arn`
  variable allows the destination log group to be configured. Note that the
  module managed log group is created regardless of whether access logging is
  enabled or whether a destination log group is provided. To control whether
  the module managed log group is created, use the 
  `include_api_gateway_stage_access_log_log_group`.
* An optional `api_name` variable has been added to the root module and the
  deployment module for using in names, descriptions and log group naming.

## 2.0.0 (December 28th, 2022)

IMPROVEMENTS

* The root module now optionally supports creating a REST API policy, controlled
  by the `include_api_gateway_rest_api_policy` variable, which defaults to
  `false`. When `true`, the `api_gateway_rest_api_source_policy_document` should
  be provided, including the required policy contents. The source policy
  document will have any references to `${api_gateway_rest_api_execution_arn}`
  replaced with the execution ARN of the created REST API.
* The new `deployment` submodule manages creating a deployment and stage for an
  existing API gateway. The module exposes an
  `api_gateway_redeployment_triggers` key-value map which when a value changes
  forces a redeployment of the stage.
* The new `domain` submodule manages creating a domain name, mapping and
  corresponding DNS records for the API gateway.

BACKWARDS INCOMPATIBILITIES / NOTES:

* This root module no longer manages domains and certificates. Instead, the
  `domain` submodule included in this module manages those. As a result,
  the `public_zone_id`, `subdomain`, `domain_name`, `certificate_arn`, 
  `create_custom_domain`, and `create_certificate` variables have been 
  removed.
* The `endpoint_types` variable has been renamed to
  `api_gateway_rest_api_endpoint_type` since it only expects a single value.

## 1.2.0 (November 22nd, 2022)

IMPROVEMENTS

* This module can now be run with version 4 of the AWS provider.

BACKWARDS INCOMPATIBILITIES / NOTES:

* This module now requires Terraform 1.0 or higher.


## 1.1.0 (May 28th, 2021)

IMPROVEMENTS

* The certificate to use on the created domain name can now be specified via the
  `certificate_arn` variable.

## 1.0.0 (May 27th, 2021)

BACKWARDS INCOMPATIBILITIES / NOTES:

* This module is now compatible with Terraform 0.14 and higher.

## 0.1.4 (September 9th, 2017) 

IMPROVEMENTS:

* The zone ID and the DNS name of the ELB are now output from the module.   