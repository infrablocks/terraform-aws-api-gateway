require 'spec_helper'

describe 'API Gateway' do
  let(:component) {vars.component}
  let(:deployment_identifier) {vars.deployment_identifier}

  let(:name) {output_for(:harness, 'name')}
  let(:id) {output_for(:harness, 'id')}

  subject {apigateway(name)}

  it {should exist}

end