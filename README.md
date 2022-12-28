Terraform AWS API Gateway
===================================

[![Version](https://img.shields.io/github/v/tag/infrablocks/terraform-aws-api-gateway?label=version&sort=semver)](https://github.com/infrablocks/terraform-aws-api-gateway/tags)
[![Build Pipeline](https://img.shields.io/circleci/build/github/infrablocks/terraform-aws-api-gateway/main?label=build-pipeline)](https://app.circleci.com/pipelines/github/infrablocks/terraform-aws-api-gateway?filter=all)
[![Maintainer](https://img.shields.io/badge/maintainer-go--atomic.io-red)](https://go-atomic.io)

A Terraform module and associated submodules for building an API gateway in AWS.

The `infrablocks/api-gateway/aws` root module:

* has no prerequisite requirements
* consists of:
    * an API Gateway REST API
    * an optional API Gateway REST API policy

Additionally, this module includes 3 submodules:

* `infrablocks/api-gateway/aws//modules/deployment` for managing an API
  Gateway stage and deployment of an API Gateway REST API
* `infrablocks/api-gateway/aws//modules/domain` for configuring a custom
  domain on an API Gateway REST API
* `infrablocks/api-gateway/aws//modules/log_permissions` for creating and
  configuring a logging role for API Gateway

The `infrablocks/api-gateway/aws//modules/deployment` module:

* requires an existing API Gateway REST API as created by the root module
* consists of:
    * an API Gateway stage
    * an API Gateway deployment

The `infrablocks/api-gateway/aws//modules/domain` module:

* requires:
    * an existing API Gateway REST API as created by the root module
    * an existing ACM certificate
* consists of:
    * an API Gateway domain
    * an API Gateway base path mapping
    * AWS Route53 records for the domain in each provided hosted zone

The `infrablocks/api-gateway/aws//modules/log_permissions` module:

* has no prerequisite requirements
* consists of:
    * an IAM role allowing the API Gateway service to manage Cloudwatch logs
    * configuration of the IAM role against the API Gateway service

Usage
-----

To use the `infrablocks/api-gateway/aws` root module, include something like the
following in your Terraform configuration:

```terraform
module "api_gateway" {
  source  = "infrablocks/api-gateway/aws"
  version = "2.0.0"

  region = "eu-west-2"

  component             = "api-gw"
  deployment_identifier = "production"
}
```

Then to use the `infrablocks/api-gateway/aws//modules/deployment` submodule:

```terraform
module "deployment" {
  source  = "infrablocks/api-gateway/aws//modules/deployment"
  version = "2.0.0"

  region = "eu-west-2"

  component             = "api-gw"
  deployment_identifier = "production"

  api_gateway_rest_api_id           = module.api_gateway.api_gateway_rest_api_id
  api_gateway_stage_name            = "default"
  api_gateway_redeployment_triggers = {
    release : 1
  }
}
```

And to use the `infrablocks/api-gateway/aws//modules/domain` submodule:

```terraform
module "domain" {
  source  = "infrablocks/api-gateway/aws//modules/domain"
  version = "2.0.0"

  region = "eu-west-2"

  component             = "api-gw"
  deployment_identifier = "production"

  api_gateway_rest_api_id                 = module.api_gateway.api_gateway_rest_api_id
  api_gateway_stage_name                  = "default"
  api_gateway_domain_name                 = "example.com"
  api_gateway_domain_name_certificate_arn = "arn:aws:acm:eu-west-2:123456789101:certificate/31bd2209-f35b-4668-b48b-324f44fedc7e"

  dns = {
    records : [
      {
        zone_id : "Z0901234DIVFOTMNA324"
      }
    ]
  }
}
```

The `infrablocks/api-gateway/aws//modules/log_permissions` module should be
used once per account, as follows:

```terraform
module "domain" {
  source  = "infrablocks/api-gateway/aws//modules/log_permissions"
  version = "2.0.0"
}
```

See the
[Terraform registry entry](https://registry.terraform.io/modules/infrablocks/api-gateway/aws/latest)
for more details.

### Inputs

#### Root Module

| Name                                          | Description                                                                                                                                           | Default  |           Required           |
|-----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|:--------:|:----------------------------:|
| `region`                                      | The region into which to deploy the API gateway REST API.                                                                                             |    -     |             Yes              |
| `component`                                   | The component for which the API gateway REST API is being created.                                                                                    |    -     |             Yes              |
| `deployment_identifier`                       | An identifier for this instantiation                                                                                                                  |    -     |             Yes              |
| `api_gateway_rest_api_endpoint_type`          | The type of the endpoints in this REST API. Valid values: `"EDGE"`, `"REGIONAL"` or `"PRIVATE"`.                                                      | `"EDGE"` |              No              |
| `api_gateway_rest_api_vpc_endpoint_ids`       | The VPC endpoint IDs to associate with the REST API when it is deployed privately. Required when `api_gateway_rest_api_endpoint_type` is `"PRIVATE"`. |    -     | Yes, depending on other vars |
| `api_gateway_rest_api_source_policy_document` | A source policy document for the policy associated with the REST API. Only required if `include_api_gateway_rest_api_policy` is `true`.               |    -     | Yes, depending on other vars |
| `include_api_gateway_rest_api_policy`         | Whether or not to include an IAM policy on the REST API.                                                                                              | `false`  |              No              |

#### Deployment Sub-module

| Name                                | Description                                                                                                    | Default | Required |
|-------------------------------------|----------------------------------------------------------------------------------------------------------------|:-------:|:--------:|
| `region`                            | The region into which to deploy the API gateway deployment.                                                    |    -    |   Yes    |
| `component`                         | The component for which the API gateway deployment is being created.                                           |    -    |   Yes    |
| `deployment_identifier`             | An identifier for this instantiation.                                                                          |    -    |   Yes    |
| `api_gateway_rest_api_id`           | The ID of the API gateway REST API for which this deployment is being managed.                                 |    -    |   Yes    |
| `api_gateway_stage_name`            | The stage name for the API gateway stage created for this deployment.                                          |    -    |   Yes    |
| `api_gateway_redeployment_triggers` | A map of key value pairs such that when any value changes, redeployment of the API gateway stage is triggered. |    -    |   Yes    |
| `tags`                              | A map of tags to add to created infrastructure components.                                                     |  `{}`   |    No    |

#### Domain Sub-module

| Name                                      | Description                                                                                      |   Default   | Required |
|-------------------------------------------|--------------------------------------------------------------------------------------------------|:-----------:|:--------:|
| `region`                                  | The region into which to deploy the API gateway domain.                                          |      -      |   Yes    |
| `component`                               | The component for which the API gateway domain is being created.                                 |      -      |   Yes    |
| `deployment_identifier`                   | An identifier for this instantiation.                                                            |      -      |   Yes    |
| `api_gateway_rest_api_id`                 | The ID of the API gateway REST API for which this domain is being managed.                       |      -      |   Yes    |
| `api_gateway_rest_api_endpoint_type`      | The type of the endpoints in this REST API. Valid values: `"EDGE"`, `"REGIONAL"` or `"PRIVATE"`. |  `"EDGE"`   |   Yes    |
| `api_gateway_stage_name`                  | The stage name for the API gateway stage created for this deployment.                            |      -      |   Yes    |
| `api_gateway_domain_name`                 | The domain name to use for the API gateway.                                                      |      -      |   Yes    |
| `api_gateway_domain_name_certificate_arn` | The ARN of a certificate to associate with the API gateway for this domain.                      |      -      |   Yes    |
| `api_gateway_domain_name_security_policy` | The security policy to use on the API gateway for this domain.                                   | `"TLS_1_2"` |    No    |
| `api_gateway_domain_name_base_path`       | The base path at which to expose the API managed by the API gateway for this domain.             |      -      |    No    |
| `dns`                                     | Details of the DNS records to create pointing at the API gateway for this domain name.           |    `[]`     |    No    |
| `tags`                                    | AWS tags to use on created infrastructure components.                                            |    `{}`     |    No    |

#### Log Permissions Sub-module

| Name | Description | Default | Required |
|------|-------------|:-------:|:--------:|

### Outputs

#### Root Module

| Name                                    | Description                                                                                                                                                  |
|-----------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `api_gateway_rest_api_name`             | The name of the created API Gateway REST API.                                                                                                                |
| `api_gateway_rest_api_id`               | The ID of the created API Gateway REST API.                                                                                                                  |
| `api_gateway_rest_api_root_resource_id` | The resource ID of the REST API's root.                                                                                                                      |
| `api_gateway_redeployment_triggers`     | A map of redeployment triggers for use in the `infrablocks/api-gateway/aws//modules/deployment` module such that a redeployment will be triggered on change. |

#### Deployment Sub-module

| Name                              | Description                                                  |
|-----------------------------------|--------------------------------------------------------------|
| `api_gateway_deployment_id`       | The ID of the API gateway deployment managed by this module. |
| `api_gateway_stage_id`            | The ID of the API gateway stage managed by this module.      |
| `api_gateway_stage_arn`           | The ARN of the API gateway stage managed by this module.     |
| `api_gateway_stage_invoke_url`    | The invoke URL of the stage managed by this module.          |
| `api_gateway_stage_execution_arn` | The execution ARN of the stage managed by this module.       |

#### Domain Sub-module

| Name                                             | Description                                                                                                                      |
|--------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| `api_gateway_domain_name_cloudfront_domain_name` | The CloudFront domain name of the domain endpoint of the API gateway for the domain. Populated when endpoint type is `"EDGE"`.   |
| `api_gateway_domain_name_cloudfront_zone_id`     | The CloudFront zone ID of the domain endpoint of the API gateway for the domain. Populated when endpoint type is `"EDGE"`.       |
| `api_gateway_domain_name_regional_domain_name`   | The regional domain name of the domain endpoint of the API gateway for the domain. Populated when endpoint type is `"REGIONAL"`. |
| `api_gateway_domain_name_regional_zone_id`       | The regional zone ID of the domain endpoint of the API gateway for the domain. Populated when endpoint type is `"REGIONAL"`.     |

#### Log Permissions Sub-module

| Name                       | Description                                                      |
|----------------------------|------------------------------------------------------------------|
| `logging_role_id`          | The ID of the managed API Gateway logging role.                  |
| `logging_role_arn`         | The ARN of the managed API Gateway logging role.                 |
| `logging_role_name`        | The name of the managed API Gateway logging role.                |
| `logging_role_policy_id`   | The ID of the policy attached to the API Gateway logging role.   |
| `logging_role_policy_name` | The name of the policy attached to the API Gateway logging role. |

### Compatibility

This module and all submodules are compatible with Terraform versions greater
than or equal to Terraform 1.3 and the Terraform AWS provider 4.0.

Development
-----------

### Machine Requirements

In order for the build to run correctly, a few tools will need to be installed
on your development machine:

* Ruby (3.1)
* Bundler
* git
* git-crypt
* gnupg
* direnv
* aws-vault

#### Mac OS X Setup

Installing the required tools is best managed by [homebrew](http://brew.sh).

To install homebrew:

```shell
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Then, to install the required tools:

```shell
# ruby
brew install rbenv
brew install ruby-build
echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
eval "$(rbenv init -)"
rbenv install 3.1.1
rbenv rehash
rbenv local 3.1.1
gem install bundler

# git, git-crypt, gnupg
brew install git
brew install git-crypt
brew install gnupg

# aws-vault
brew cask install

# direnv
brew install direnv
echo "$(direnv hook bash)" >> ~/.bash_profile
echo "$(direnv hook zsh)" >> ~/.zshrc
eval "$(direnv hook $SHELL)"

direnv allow <repository-directory>
```

### Running the build

Running the build requires an AWS account and AWS credentials. You are free to
configure credentials however you like as long as an access key ID and secret
access key are available. These instructions utilise
[aws-vault](https://github.com/99designs/aws-vault) which makes credential
management easy and secure.

To run the full build, including unit and integration tests, execute:

```shell
aws-vault exec <profile> -- ./go
```

To run the unit tests, execute:

```shell
aws-vault exec <profile> -- ./go test:unit
```

To run the integration tests, execute:

```shell
aws-vault exec <profile> -- ./go test:integration
```

To provision the module prerequisites:

```shell
aws-vault exec <profile> -- ./go deployment:prerequisites:provision[<deployment_identifier>]
```

To provision the module contents:

```shell
aws-vault exec <profile> -- ./go deployment:root:provision[<deployment_identifier>]
```

To destroy the module contents:

```shell
aws-vault exec <profile> -- ./go deployment:root:destroy[<deployment_identifier>]
```

To destroy the module prerequisites:

```shell
aws-vault exec <profile> -- ./go deployment:prerequisites:destroy[<deployment_identifier>]
```

Configuration parameters can be overridden via environment variables. For
example, to run the unit tests with a seed of `"testing"`, execute:

```shell
SEED=testing aws-vault exec <profile> -- ./go test:unit
```

When a seed is provided via an environment variable, infrastructure will not be
destroyed at the end of test execution. This can be useful during development
to avoid lengthy provision and destroy cycles.

To subsequently destroy unit test infrastructure for a given seed:

```shell
FORCE_DESTROY=yes SEED=testing aws-vault exec <profile> -- ./go test:unit
```

### Common Tasks

#### Generating an SSH key pair

To generate an SSH key pair:

```shell
ssh-keygen -m PEM -t rsa -b 4096 -C integration-test@example.com -N '' -f config/secrets/keys/bastion/ssh
```

#### Generating a self-signed certificate

To generate a self signed certificate:

```shell
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365
```

To decrypt the resulting key:

```shell
openssl rsa -in key.pem -out ssl.key
```

#### Managing CircleCI keys

To encrypt a GPG key for use by CircleCI:

```shell
openssl aes-256-cbc \
  -e \
  -md sha1 \
  -in ./config/secrets/ci/gpg.private \
  -out ./.circleci/gpg.private.enc \
  -k "<passphrase>"
```

To check decryption is working correctly:

```shell
openssl aes-256-cbc \
  -d \
  -md sha1 \
  -in ./.circleci/gpg.private.enc \
  -k "<passphrase>"
```

Contributing
------------

Bug reports and pull requests are welcome on GitHub at
https://github.com/infrablocks/terraform-aws-api-gateway. This project is
intended to be a safe, welcoming space for
collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.

License
-------

The library is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
