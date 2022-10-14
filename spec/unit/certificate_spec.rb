# frozen_string_literal: true

require 'spec_helper'

describe 'certificate' do
  let(:component) do
    var(role: :root, name: 'component')
  end
  let(:deployment_identifier) do
    var(role: :root, name: 'deployment_identifier')
  end

  before(:context) do
    @plan = plan(role: :root) do |vars|
      vars.create_certificate = 'yes'
      vars.create_custom_domain = 'no'
    end
  end

  it 'creates an ACM certificate' do
    expect(@plan)
      .to(include_resource_creation(type: 'aws_acm_certificate'))
  end
end
