# frozen_string_literal: true

require 'spec_helper'

describe 'REST API' do
  let(:component) do
    var(role: :root, name: 'component')
  end
  let(:deployment_identifier) do
    var(role: :root, name: 'deployment_identifier')
  end

  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root)
    end

    it 'creates a REST API' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_rest_api'))
    end

    it 'includes component and deployment identifier in the REST API name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_rest_api')
              .with_attribute_value(
                :name, "api-#{component}-#{deployment_identifier}"
              ))
    end

    it 'includes component and deployment identifier in the REST API ' \
       'description' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_rest_api')
              .with_attribute_value(
                :description,
                including(component)
                  .and(including(deployment_identifier))
              ))
    end

    it 'uses an endpoint type of "EDGE"' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_rest_api')
              .with_attribute_value(
                [:endpoint_configuration, 0, :types],
                ['EDGE']
              ))
    end

    it 'does not set any VPC endpoint IDs in the endpoint configuration' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_rest_api')
              .with_attribute_value(
                [:endpoint_configuration, 0, :vpc_endpoint_ids], a_nil_value
              ))
    end

    it 'outputs redeployment triggers' do
      expect(@plan)
        .to(include_output_creation(name: 'api_gateway_redeployment_triggers'))
    end
  end

  describe 'when api_gateway_rest_api_endpoint_type provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.api_gateway_rest_api_endpoint_type = 'REGIONAL'
      end
    end

    it 'uses the provided endpoint type' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_rest_api')
              .with_attribute_value(
                [:endpoint_configuration, 0, :types],
                ['REGIONAL']
              ))
    end
  end

  describe 'when api_gateway_rest_api_vpc_endpoint_ids is provided' do
    before(:context) do
      @vpc_endpoint_id = 'vpce-009b87afafea07646'
      @plan = plan(role: :root) do |vars|
        vars.api_gateway_rest_api_endpoint_type = 'PRIVATE'
        vars.api_gateway_rest_api_vpc_endpoint_ids = [@vpc_endpoint_id]
      end
    end

    it 'uses the provided VPC endpoint IDs in the endpoint configuration' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_rest_api')
              .with_attribute_value(
                [:endpoint_configuration, 0, :vpc_endpoint_ids],
                [@vpc_endpoint_id]
              ))
    end
  end
end
