## Unreleased

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