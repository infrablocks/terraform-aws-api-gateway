# frozen_string_literal: true

require 'spec_helper'

describe 'full' do
  before(:context) do
    apply(role: :full)
  end

  after(:context) do
    destroy(role: :full)
  end

  let(:api_gateway_name) { output(role: :full, name: 'api_gateway_name') }

  subject { apigateway(api_gateway_name) }

  it { is_expected.to exist }
end
