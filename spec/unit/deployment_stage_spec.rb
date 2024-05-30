# frozen_string_literal: true

require 'spec_helper'

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
      @plan = plan(role: :deployment) do |vars|
        vars.api_gateway_rest_api_id =
          output(role: :prerequisites, name: 'api_gateway_rest_api_id')
        vars.api_gateway_stage_name = 'default'
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
        vars.enable_xray_tracing = true
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
        vars.enable_xray_tracing = false
      end
    end

    it 'does not enable X-Ray tracing' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_stage')
              .with_attribute_value(:xray_tracing_enabled, false))
    end
  end
end
