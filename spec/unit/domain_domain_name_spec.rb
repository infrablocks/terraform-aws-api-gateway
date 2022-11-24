# frozen_string_literal: true

require 'spec_helper'

describe 'domain name' do
  describe 'by default' do
    before(:context) do
      @api_gateway_rest_api_id =
        output(role: :prerequisites, name: 'api_gateway_rest_api_id')
      @api_gateway_stage_name = 'default'
      @api_gateway_domain_name =
        output(role: :prerequisites, name: 'domain_name')
      @api_gateway_domain_name_certificate_arn =
        output(role: :prerequisites, name: 'certificate_arn')

      @plan = plan(role: :domain) do |vars|
        vars.api_gateway_rest_api_id = @api_gateway_rest_api_id
        vars.api_gateway_stage_name = @api_gateway_stage_name
        vars.api_gateway_domain_name = @api_gateway_domain_name
        vars.api_gateway_domain_name_certificate_arn =
          @api_gateway_domain_name_certificate_arn
      end
    end

    it 'creates an API gateway domain name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .once)
    end

    it 'uses the provided domain name on the API gateway domain name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .with_attribute_value(:domain_name, @api_gateway_domain_name))
    end

    it 'uses an endpoint type of EDGE on the API gateway domain name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .with_attribute_value(
                [:endpoint_configuration, 0, :types],
                ['EDGE']
              ))
    end

    it 'uses a security policy of TLS_1_2 on the API gateway domain name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .with_attribute_value(
                :security_policy, 'TLS_1_2'
              ))
    end

    it 'uses the provided certificate ARN as the API gateway domain name ' \
       'certificate ARN' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .with_attribute_value(
                :certificate_arn, @api_gateway_domain_name_certificate_arn
              ))
    end

    it 'does not set a regional certificate ARN on the API gateway ' \
       'domain name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .with_attribute_value(
                :regional_certificate_arn, a_nil_value
              ))
    end

    it 'outputs the API gateway domain name CloudFront domain name' do
      expect(@plan)
        .to(include_output_creation(
              name: 'api_gateway_domain_name_cloudfront_domain_name'
            ))
    end

    it 'outputs the API gateway domain name CloudFront zone ID' do
      expect(@plan)
        .to(include_output_creation(
              name: 'api_gateway_domain_name_cloudfront_zone_id'
            ))
    end

    it 'outputs the API gateway domain name regional domain name' do
      expect(@plan)
        .to(include_output_creation(
              name: 'api_gateway_domain_name_regional_domain_name'
            ))
    end

    it 'outputs the API gateway domain name regional zone ID' do
      expect(@plan)
        .to(include_output_creation(
              name: 'api_gateway_domain_name_regional_zone_id'
            ))
    end
  end

  describe 'when api_gateway_rest_api_endpoint_type is "REGIONAL"' do
    before(:context) do
      @api_gateway_rest_api_id =
        output(role: :prerequisites, name: 'api_gateway_rest_api_id')
      @api_gateway_stage_name = 'default'
      @api_gateway_domain_name =
        output(role: :prerequisites, name: 'domain_name')
      @api_gateway_domain_name_certificate_arn =
        output(role: :prerequisites, name: 'certificate_arn')

      @plan = plan(role: :domain) do |vars|
        vars.api_gateway_rest_api_id = @api_gateway_rest_api_id
        vars.api_gateway_stage_name = @api_gateway_stage_name
        vars.api_gateway_domain_name = @api_gateway_domain_name
        vars.api_gateway_domain_name_certificate_arn =
          @api_gateway_domain_name_certificate_arn
        vars.api_gateway_rest_api_endpoint_type = 'REGIONAL'
      end
    end

    it 'uses an endpoint type of REGIONAL on the API gateway domain name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .with_attribute_value(
                [:endpoint_configuration, 0, :types],
                ['REGIONAL']
              ))
    end

    it 'does not set a certificate ARN on the API gateway domain name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .with_attribute_value(
                :certificate_arn, a_nil_value
              ))
    end

    it 'uses the provided certificate ARN as the regional certificate ARN ' \
       'on the API gateway domain name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .with_attribute_value(
                :regional_certificate_arn,
                @api_gateway_domain_name_certificate_arn
              ))
    end
  end

  describe 'when api_gateway_rest_api_endpoint_type is "EDGE"' do
    before(:context) do
      @api_gateway_rest_api_id =
        output(role: :prerequisites, name: 'api_gateway_rest_api_id')
      @api_gateway_stage_name = 'default'
      @api_gateway_domain_name =
        output(role: :prerequisites, name: 'domain_name')
      @api_gateway_domain_name_certificate_arn =
        output(role: :prerequisites, name: 'certificate_arn')

      @plan = plan(role: :domain) do |vars|
        vars.api_gateway_rest_api_id = @api_gateway_rest_api_id
        vars.api_gateway_stage_name = @api_gateway_stage_name
        vars.api_gateway_domain_name = @api_gateway_domain_name
        vars.api_gateway_domain_name_certificate_arn =
          @api_gateway_domain_name_certificate_arn
        vars.api_gateway_rest_api_endpoint_type = 'EDGE'
      end
    end

    it 'uses an endpoint type of EDGE on the API gateway domain name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .with_attribute_value(
                [:endpoint_configuration, 0, :types],
                ['EDGE']
              ))
    end

    it 'uses the provided certificate ARN as the certificate ARN ' \
       'on the API gateway domain name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .with_attribute_value(
                :certificate_arn, @api_gateway_domain_name_certificate_arn
              ))
    end

    it 'does not set a regional certificate ARN on the API gateway ' \
       'domain name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .with_attribute_value(
                :regional_certificate_arn, a_nil_value
              ))
    end
  end

  describe 'when api_gateway_domain_name_security_policy is provided' do
    before(:context) do
      @api_gateway_rest_api_id =
        output(role: :prerequisites, name: 'api_gateway_rest_api_id')
      @api_gateway_stage_name = 'default'
      @api_gateway_domain_name =
        output(role: :prerequisites, name: 'domain_name')
      @api_gateway_domain_name_certificate_arn =
        output(role: :prerequisites, name: 'certificate_arn')

      @plan = plan(role: :domain) do |vars|
        vars.api_gateway_rest_api_id = @api_gateway_rest_api_id
        vars.api_gateway_stage_name = @api_gateway_stage_name
        vars.api_gateway_domain_name = @api_gateway_domain_name
        vars.api_gateway_domain_name_certificate_arn =
          @api_gateway_domain_name_certificate_arn
        vars.api_gateway_domain_name_security_policy = 'TLS_1_0'
      end
    end

    it 'uses the provided security policy on the API gateway domain name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_domain_name')
              .with_attribute_value(
                :security_policy, 'TLS_1_0'
              ))
    end
  end
end
