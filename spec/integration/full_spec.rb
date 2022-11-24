# frozen_string_literal: true

require 'spec_helper'

describe 'full' do
  before(:context) do
    apply(role: :full)
  end

  after(:context) do
    destroy(role: :full)
  end

  let(:api_gateway_rest_api_name) do
    output(role: :full, name: 'api_gateway_rest_api_name')
  end
  let(:certificate_arn) do
    output(role: :full, name: 'certificate_arn')
  end

  describe 'API gateway' do
    subject { apigateway(api_gateway_rest_api_name) }

    it { is_expected.to exist }
  end
end
