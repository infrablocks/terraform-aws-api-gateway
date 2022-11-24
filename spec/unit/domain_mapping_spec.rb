# frozen_string_literal: true

require 'spec_helper'

describe 'mapping' do
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

    it 'creates an API gateway base path mapping' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_base_path_mapping')
              .once)
    end

    it 'uses the provided REST API ID on the API gateway base path mapping' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_base_path_mapping')
              .with_attribute_value(:api_id, @api_gateway_rest_api_id))
    end

    it 'uses the provided stage name on the API gateway base path mapping' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_base_path_mapping')
              .with_attribute_value(:stage_name, @api_gateway_stage_name))
    end

    it 'uses the provided domain name on the API gateway base path mapping' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_base_path_mapping')
              .with_attribute_value(:domain_name, @api_gateway_domain_name))
    end

    it 'uses a base path of null on the API gateway base path mapping' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_base_path_mapping')
              .with_attribute_value(:base_path, a_nil_value))
    end
  end

  describe 'when api_gateway_domain_name_base_path provided' do
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
        vars.api_gateway_domain_name_base_path = 'api'
      end
    end

    it 'uses the provided base path on the API gateway base path mapping' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_base_path_mapping')
              .with_attribute_value(:base_path, 'api'))
    end
  end
end
