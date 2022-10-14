# frozen_string_literal: true

require 'spec_helper'

describe 'API Gateway' do
  subject { apigateway(name) }

  let(:component) { vars.component }
  let(:deployment_identifier) { vars.deployment_identifier }

  let(:name) { output_for(:harness, 'name') }
  let(:id) { output_for(:harness, 'id') }

  it { is_expected.to exist }
end
