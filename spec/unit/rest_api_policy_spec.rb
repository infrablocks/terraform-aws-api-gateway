# frozen_string_literal: true

require 'spec_helper'

describe 'REST API policy' do
  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root)
    end

    it 'does not create a REST API policy' do
      expect(@plan)
        .not_to(include_resource_creation(
                  type: 'aws_api_gateway_rest_api_policy'
                ))
    end
  end

  describe 'when include_api_gateway_rest_api_policy is true' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.include_api_gateway_rest_api_policy = true
        vars.api_gateway_rest_api_source_policy_document =
          File.read('spec/unit/test-rest-api-policy.json')
      end
    end

    it 'creates a REST API policy' do
      expect(@plan)
        .to(include_resource_creation(
              type: 'aws_api_gateway_rest_api_policy'
            ))
    end
  end

  describe 'when include_api_gateway_rest_api_policy is false' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.include_api_gateway_rest_api_policy = false
      end
    end

    it 'does not create a REST API policy' do
      expect(@plan)
        .not_to(include_resource_creation(
                  type: 'aws_api_gateway_rest_api_policy'
                ))
    end
  end
end
