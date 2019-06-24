require 'spec_helper'

describe 'Certificate' do
  include_context :terraform

  let(:component) {vars.component}
  let(:deployment_identifier) {vars.deployment_identifier}
  let(:subdomain) {vars.subdomain}
  let(:domain_name) {vars.domain_name}

  subject {acm("#{subdomain}.#{domain_name}")}

  let(:name) {output_for(:harness, 'name')}

  it {should exist}

end