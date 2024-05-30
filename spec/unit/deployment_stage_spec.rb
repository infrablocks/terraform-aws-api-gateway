# frozen_string_literal: true

require 'spec_helper'

RSpec::Matchers.define_negated_matcher(
  :a_non_nil_value, :a_nil_value
)

describe 'stage' do
  let(:component) do
    var(role: :deployment, name: 'component')
  end
  let(:deployment_identifier) do
    var(role: :deployment, name: 'deployment_identifier')
  end
  let(:api_gateway_rest_api_id) do
    output(role: :prerequisites, name: 'api_gateway_rest_api_id')
  end

  describe 'by default' do
    before(:context) do
      @api_gateway_stage_name = 'default'
      @plan = plan(role: :deployment) do |vars|
        vars.api_gateway_rest_api_id =
          output(role: :prerequisites, name: 'api_gateway_rest_api_id')
        vars.api_gateway_stage_name = @api_gateway_stage_name
        vars.api_gateway_redeployment_triggers = {
          some_hash: '1234'
        }
      end
    end

    it 'creates a stage' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage'))
    end

    it 'uses the provided REST API ID' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage')
              .with_attribute_value(:rest_api_id, api_gateway_rest_api_id))
    end

    it 'includes the component and deployment identifier in the description' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage')
              .with_attribute_value(
                :description,
                including(component)
                  .and(including(deployment_identifier))
              ))
    end

    it 'includes component and deployment identifier tags' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Component: component,
                  DeploymentIdentifier: deployment_identifier
                )
              ))
    end

    it 'includes a stage tag' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Stage: 'default'
                )
              ))
    end

    it 'does not enable X-Ray tracing' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage')
              .with_attribute_value(:xray_tracing_enabled, false))
    end

    it 'does not enable access logging' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage')
              .with_attribute_value(:access_log_settings, a_nil_value))
    end

    it 'creates a log group for the access logs' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_cloudwatch_log_group')
              .once)
    end

    it 'includes the component in the log group name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_cloudwatch_log_group')
              .with_attribute_value(:name, match(/.*#{component}.*/)))
    end

    it 'includes the deployment identifier in the log group name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_cloudwatch_log_group')
              .with_attribute_value(
                :name, match(/.*#{deployment_identifier}.*/)
              ))
    end

    it 'includes the stage name in the log group name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_cloudwatch_log_group')
              .with_attribute_value(
                :name, match(/.*#{@api_gateway_stage_name}.*/)
              ))
    end
  end

  describe 'when tags provided' do
    before(:context) do
      @plan = plan(role: :deployment) do |vars|
        vars.api_gateway_rest_api_id =
          output(role: :prerequisites, name: 'api_gateway_rest_api_id')
        vars.api_gateway_stage_name = 'default'
        vars.api_gateway_redeployment_triggers = {
          some_hash: '1234'
        }
        vars.tags = {
          Tag1: 'value1',
          Tag2: 'value2'
        }
      end
    end

    it 'includes component and deployment identifier tags' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Component: component,
                  DeploymentIdentifier: deployment_identifier
                )
              ))
    end

    it 'includes a stage tag' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Stage: 'default'
                )
              ))
    end

    it 'includes the provided tags' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Tag1: 'value1',
                  Tag2: 'value2'
                )
              ))
    end

    it 'outputs the API gateway stage ID' do
      expect(@plan)
        .to(include_output_creation(
              name: 'api_gateway_stage_id'
            ))
    end

    it 'outputs the API gateway stage ARN' do
      expect(@plan)
        .to(include_output_creation(
              name: 'api_gateway_stage_arn'
            ))
    end

    it 'outputs the API gateway stage invoke URL' do
      expect(@plan)
        .to(include_output_creation(
              name: 'api_gateway_stage_invoke_url'
            ))
    end

    it 'outputs the API gateway stage execution ARN' do
      expect(@plan)
        .to(include_output_creation(
              name: 'api_gateway_stage_execution_arn'
            ))
    end
  end

  describe 'when enable_xray_tracing is true' do
    before(:context) do
      @plan = plan(role: :deployment) do |vars|
        vars.api_gateway_rest_api_id =
          output(role: :prerequisites, name: 'api_gateway_rest_api_id')
        vars.api_gateway_stage_name = 'default'
        vars.api_gateway_redeployment_triggers = {
          some_hash: '1234'
        }
        vars.enable_api_gateway_stage_xray_tracing = true
      end
    end

    it 'enables X-Ray tracing' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage')
              .with_attribute_value(:xray_tracing_enabled, true))
    end
  end

  describe 'when enable_xray_tracing is false' do
    before(:context) do
      @plan = plan(role: :deployment) do |vars|
        vars.api_gateway_rest_api_id =
          output(role: :prerequisites, name: 'api_gateway_rest_api_id')
        vars.api_gateway_stage_name = 'default'
        vars.api_gateway_redeployment_triggers = {
          some_hash: '1234'
        }
        vars.enable_api_gateway_stage_xray_tracing = false
      end
    end

    it 'does not enable X-Ray tracing' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage')
              .with_attribute_value(:xray_tracing_enabled, false))
    end
  end

  describe 'when enable_api_gateway_stage_access_logging is true' do
    describe 'by default' do
      before(:context) do
        @plan = plan(role: :deployment) do |vars|
          vars.api_gateway_rest_api_id =
            output(role: :prerequisites, name: 'api_gateway_rest_api_id')
          vars.api_gateway_stage_name = 'default'
          vars.api_gateway_redeployment_triggers = {
            some_hash: '1234'
          }
          vars.enable_api_gateway_stage_access_logging = true
        end
      end

      it 'enables access logging' do
        expect(@plan)
          .to(include_resource_creation(type: 'aws_api_gateway_stage')
                .with_attribute_value(:access_log_settings, a_non_nil_value))
      end

      # rubocop:disable RSpec/ExampleLength
      it 'logs everything' do
        expect(@plan)
          .to(include_resource_creation(type: 'aws_api_gateway_stage')
                .with_attribute_value(
                  [:access_log_settings, 0, :format],
                  '{' \
                    '"accountId": "$context.accountId", ' \
                    '"apiId": "$context.apiId", ' \
                    '"authenticate.error": "$context.authenticate.error", ' \
                    '"authenticate.latency": ' \
                    '"$context.authenticate.latency", ' \
                    '"authenticate.status": "$context.authenticate.status", ' \
                    '"authorize.error": "$context.authorize.error", ' \
                    '"authorize.latency": "$context.authorize.latency", ' \
                    '"authorize.status": "$context.authorize.status", ' \
                    '"authorizer.error": "$context.authorizer.error", ' \
                    '"authorizer.integrationLatency": ' \
                    '"$context.authorizer.integrationLatency", ' \
                    '"authorizer.integrationStatus": ' \
                    '"$context.authorizer.integrationStatus", ' \
                    '"authorizer.latency": "$context.authorizer.latency", ' \
                    '"authorizer.principalId": ' \
                    '"$context.authorizer.principalId", ' \
                    '"authorizer.requestId": ' \
                    '"$context.authorizer.requestId", ' \
                    '"authorizer.status": "$context.authorizer.status", ' \
                    '"awsEndpointRequestId": ' \
                    '"$context.awsEndpointRequestId", ' \
                    '"customDomain.basePathMatched": ' \
                    '"$context.customDomain.basePathMatched", ' \
                    '"deploymentId": "$context.deploymentId", ' \
                    '"domainName": "$context.domainName", ' \
                    '"domainPrefix": "$context.domainPrefix", ' \
                    '"endpointType": "$context.endpointType", ' \
                    '"error.message": "$context.error.message", ' \
                    '"error.messageString": "$context.error.messageString", ' \
                    '"error.responseType": "$context.error.responseType", ' \
                    '"error.validationErrorString": ' \
                    '"$context.error.validationErrorString", ' \
                    '"extendedRequestId": "$context.extendedRequestId", ' \
                    '"httpMethod": "$context.httpMethod", ' \
                    '"identity.accountId": "$context.identity.accountId", ' \
                    '"identity.apiKey": "$context.identity.apiKey", ' \
                    '"identity.apiKeyId": "$context.identity.apiKeyId", ' \
                    '"identity.caller": "$context.identity.caller", ' \
                    '"identity.cognitoAuthenticationProvider": ' \
                    '"$context.identity.cognitoAuthenticationProvider", ' \
                    '"identity.cognitoAuthenticationType": ' \
                    '"$context.identity.cognitoAuthenticationType", ' \
                    '"identity.cognitoIdentityId": ' \
                    '"$context.identity.cognitoIdentityId", ' \
                    '"identity.cognitoIdentityPoolId": ' \
                    '"$context.identity.cognitoIdentityPoolId", ' \
                    '"identity.principalOrgId": ' \
                    '"$context.identity.principalOrgId", ' \
                    '"identity.sourceIp": "$context.identity.sourceIp", ' \
                    '"identity.clientCert.clientCertPem": ' \
                    '"$context.identity.clientCert.clientCertPem", ' \
                    '"identity.clientCert.subjectDN": ' \
                    '"$context.identity.clientCert.subjectDN", ' \
                    '"identity.clientCert.issuerDN": ' \
                    '"$context.identity.clientCert.issuerDN", ' \
                    '"identity.clientCert.serialNumber": ' \
                    '"$context.identity.clientCert.serialNumber", ' \
                    '"identity.clientCert.validity.notBefore": ' \
                    '"$context.identity.clientCert.validity.notBefore", ' \
                    '"identity.clientCert.validity.notAfter": ' \
                    '"$context.identity.clientCert.validity.notAfter", ' \
                    '"identity.vpcId": "$context.identity.vpcId", ' \
                    '"identity.vpceId": "$context.identity.vpceId", ' \
                    '"identity.user": "$context.identity.user", ' \
                    '"identity.userAgent": "$context.identity.userAgent", ' \
                    '"identity.userArn": "$context.identity.userArn", ' \
                    '"integration.error": "$context.integration.error", ' \
                    '"integration.integrationStatus": ' \
                    '"$context.integration.integrationStatus", ' \
                    '"integration.latency": "$context.integration.latency", ' \
                    '"integration.requestId": ' \
                    '"$context.integration.requestId", ' \
                    '"integration.status": "$context.integration.status", ' \
                    '"integrationLatency": "$context.integrationLatency", ' \
                    '"integrationStatus": "$context.integrationStatus", ' \
                    '"isCanaryRequest": "$context.isCanaryRequest", ' \
                    '"path": "$context.path", ' \
                    '"protocol": "$context.protocol", ' \
                    '"requestId": "$context.requestId", ' \
                    '"responseLength": "$context.responseLength", ' \
                    '"responseLatency": "$context.responseLatency", ' \
                    '"responseOverride.status": ' \
                    '"$context.responseOverride.status", ' \
                    '"requestTime": "$context.requestTime", ' \
                    '"requestTimeEpoch": "$context.requestTimeEpoch", ' \
                    '"resourceId": "$context.resourceId", ' \
                    '"resourcePath": "$context.resourcePath", ' \
                    '"stage": "$context.stage", ' \
                    '"status": "$context.status", ' \
                    '"waf.error": "$context.waf.error", ' \
                    '"waf.latency": "$context.waf.latency", ' \
                    '"waf.status": "$context.waf.status", ' \
                    '"wafResponseCode": "$context.wafResponseCode", ' \
                    '"webaclArn": "$context.webaclArn", ' \
                    '"xrayTraceId": "$context.xrayTraceId"' \
                    '}'
                ))
      end
      # rubocop:enable RSpec/ExampleLength
    end

    describe 'when api_gateway_stage_access_logging_log_group_arn provided' do
      before(:context) do
        @log_group_arn = output(role: :prerequisites, name: 'log_group_arn')
        @plan = plan(role: :deployment) do |vars|
          vars.api_gateway_rest_api_id =
            output(role: :prerequisites, name: 'api_gateway_rest_api_id')
          vars.api_gateway_stage_name = 'default'
          vars.api_gateway_redeployment_triggers = {
            some_hash: '1234'
          }
          vars.api_gateway_stage_access_logging_log_group_arn = @log_group_arn
          vars.enable_api_gateway_stage_access_logging = true

        end
      end

      it 'uses the provided log group ARN' do
        expect(@plan)
          .to(include_resource_creation(type: 'aws_api_gateway_stage')
                .with_attribute_value(
                  [:access_log_settings, 0, :destination_arn],
                  @log_group_arn))
      end
    end
  end

  describe 'when enable_api_gateway_stage_access_logging is false' do
    describe 'by default' do
      before(:context) do
        @plan = plan(role: :deployment) do |vars|
          vars.api_gateway_rest_api_id =
            output(role: :prerequisites, name: 'api_gateway_rest_api_id')
          vars.api_gateway_stage_name = 'default'
          vars.api_gateway_redeployment_triggers = {
            some_hash: '1234'
          }
          vars.enable_api_gateway_stage_access_logging = false
        end
      end

      it 'does not enable access logging' do
        expect(@plan)
          .to(include_resource_creation(type: 'aws_api_gateway_stage')
                .with_attribute_value(:access_log_settings, a_nil_value))
      end
    end
  end
end
