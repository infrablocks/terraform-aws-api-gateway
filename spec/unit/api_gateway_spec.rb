# frozen_string_literal: true

require 'spec_helper'

describe 'API Gateway' do
  let(:component) do
    var(role: :root, name: 'component')
  end
  let(:deployment_identifier) do
    var(role: :root, name: 'deployment_identifier')
  end

  describe 'when create certificate and custom domain disabled' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.create_certificate = 'no'
        vars.create_custom_domain = 'no'
      end
    end

    it 'creates an API gateway' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_rest_api'))
    end

    it 'uses component and deployment identifier in the API gateway name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_rest_api')
              .with_attribute_value(
                :name, "api-#{component}-#{deployment_identifier}"
              ))
    end
  end
end
