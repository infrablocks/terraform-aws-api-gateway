Terraform AWS API Gateway
===================================

[![CircleCI](https://circleci.com/gh/infrablocks/terraform-aws-api-gateway.svg?style=svg)](https://circleci.com/gh/infrablocks/terraform-aws-api-gateway)

A Terraform module for building a API gateway in AWS.

The API gateway requires:
* An existing VPC
* Some existing subnets
* A domain name and public and private hosted zones
 
The API gateway consists of:
* Rest api
* ACM certificate
* Custom DNS


Usage
-----

To use the module, include something like the following in your terraform 
configuration:

```hcl-terraform
module "api_gateway" {
  source  = "infrablocks/network-load-balancer/aws"
  region                = "eu-west-2"
  component             = "api-gw"
  deployment_identifier = "production"
  domain_name           = "example.com"
  subdomain             = "api.production"
  public_zone_id        = "AAAABBBCCCCCC"
}
```


### Inputs

| Name                             | Description                                                                   | Default             | Required                             |
|----------------------------------|-------------------------------------------------------------------------------|:-------------------:|:------------------------------------:|
| region                           | The region into which to deploy the API gateway                             | -                   | yes                                  |
| component| The component for which the load balancer is being created    |- | yes|
| deployment_identifier|An identifier for this instantiation                                           |- | yes |
| domain_name| The domain name of the supplied Route 53 zones | - | yes|
| subdomain| The subdomain name for the API to be used as custom domain name| - | yes |
| public_zone_id|The ID of the public Route 53 zone |- | yes |
| endpoint_types| ist of endpoint types. This resource currently only supports managing a single value. Valid values: EDGE, REGIONAL or PRIVATE| REGIONAL| no|


### Outputs

| Name                                    | Description                                               |
|-----------------------------------------|-----------------------------------------------------------|
| name                                    | The name of the created API Gateway                               |
| id                                     | The id of the created API Gateway                               |
| address                                 | The address of the deployed API Gateway      |
| certificate_arn                         | The ARN of the created Service Certificate                |


Development
-----------

### Machine Requirements

In order for the build to run correctly, a few tools will need to be installed on your
development machine:

* Ruby (2.3.1)
* Bundler
* git
* git-crypt
* gnupg
* direnv

#### Mac OS X Setup

Installing the required tools is best managed by [homebrew](http://brew.sh).

To install homebrew:

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Then, to install the required tools:

```
# ruby
brew install rbenv
brew install ruby-build
echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
eval "$(rbenv init -)"
rbenv install 2.3.1
rbenv rehash
rbenv local 2.3.1
gem install bundler

# git, git-crypt, gnupg
brew install git
brew install git-crypt
brew install gnupg

# direnv
brew install direnv
echo "$(direnv hook bash)" >> ~/.bash_profile
echo "$(direnv hook zsh)" >> ~/.zshrc
eval "$(direnv hook $SHELL)"

direnv allow <repository-directory>
```

### Running the build

To provision module infrastructure, run tests and then destroy that infrastructure,
execute:

```bash
./go
```

To provision the module prerequisites:

```bash
./go deployment:prerequisites:provision[<deployment_identifier>]
```

To provision the module contents:

```bash
./go deployment:harness:provision[<deployment_identifier>]
```

To destroy the module contents:

```bash
./go deployment:harness:destroy[<deployment_identifier>]
```

To destroy the module prerequisites:

```bash
./go deployment:prerequisites:destroy[<deployment_identifier>]
```


### Common Tasks

#### Generating an SSH key pair

To generate an SSH key pair:

```
ssh-keygen -t rsa -b 4096 -C integration-test@example.com -N '' -f config/secrets/keys/bastion/ssh
```

#### Managing CircleCI keys

To encrypt a GPG key for use by CircleCI:

```bash
openssl aes-256-cbc \
  -e \
  -md sha1 \
  -in ./config/secrets/ci/gpg.private \
  -out ./.circleci/gpg.private.enc \
  -k "<passphrase>"
```

To check decryption is working correctly:

```bash
openssl aes-256-cbc \
  -d \
  -md sha1 \
  -in ./.circleci/gpg.private.enc \
  -k "<passphrase>"
```

Contributing
------------

Bug reports and pull requests are welcome on GitHub at https://github.com/infrablocks/terraform-aws-network-load-balancer. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to 
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


License
-------

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
