# frozen_string_literal: true

require 'spec_helper'

describe 'Certificate' do
  before(:context) do
    @plan = plan(role: :root) do |vars|
      vars.create_certificate = 'yes'
      vars.create_custom_domain = 'yes'
    end
  end

  let(:component) do
    var(role: :root, name: 'component')
  end
  let(:deployment_identifier) do
    var(role: :root, name: 'deployment_identifier')
  end

  let(:name) do
    output(role: :root, name: 'name')
  end
  let(:subdomain) do
    output(role: :root, name: 'subdomain')
  end
  let(:domain_name) do
    output(role: :root, name: 'domain_name')
  end

  it { is_expected.to exist }
end
