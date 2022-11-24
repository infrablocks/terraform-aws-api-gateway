# frozen_string_literal: true

require 'spec_helper'

describe 'deployment' do
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
      @plan = plan(role: :deployment) do |vars|
        vars.api_gateway_rest_api_id =
          output(role: :prerequisites, name: 'api_gateway_rest_api_id')
        vars.api_gateway_stage_name = 'default'
        vars.api_gateway_redeployment_triggers = {
          some_hash: '1234'
        }
      end
    end

    it 'creates a deployment' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_deployment')
              .once)
    end

    it 'uses the provided REST API ID' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_deployment')
              .with_attribute_value(:rest_api_id, api_gateway_rest_api_id))
    end

    it 'includes the component and deployment identifier in the description' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_deployment')
              .with_attribute_value(
                :description,
                including(component)
                  .and(including(deployment_identifier))
              ))
    end

    it 'uses the provided redeployment triggers' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_deployment')
              .with_attribute_value(:triggers, {
                                      some_hash: '1234'
                                    }))
    end

    it 'outputs the API gateway deployment ID' do
      expect(@plan)
        .to(include_output_creation(
              name: 'api_gateway_deployment_id'
            ))
    end
  end
end
