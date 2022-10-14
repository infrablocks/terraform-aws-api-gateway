# # frozen_string_literal: true
#
# require 'spec_helper'
#
# describe 'Certificate' do
#   subject { acm("#{subdomain}.#{domain_name}") }
#
#   include_context 'terraform'
#
#   let(:component) { vars.component }
#   let(:name) { output_for(:harness, 'name') }
#   let(:deployment_identifier) { vars.deployment_identifier }
#   let(:subdomain) { vars.subdomain }
#   let(:domain_name) { vars.domain_name }
#
#   # it {should exist}
# end
