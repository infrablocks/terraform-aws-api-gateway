require 'spec_helper'
require 'awspec/type/route53_hosted_zone'

describe 'DNS Records' do
  include_context :terraform

  let(:component) {vars.component}
  let(:deployment_identifier) {vars.deployment_identifier}
  let(:subdomain) {vars.subdomain}
  let(:domain_name) {vars.domain_name}

  let(:name) {output_for(:harness, 'name')}

  let(:public_hosted_zone) {
    route53_hosted_zone(vars.public_zone_id)
  }

  it 'outputs the address' do
    expect(output_for(:harness, 'address'))
        .to(eq("https://#{subdomain}.#{domain_name}"))
  end

end