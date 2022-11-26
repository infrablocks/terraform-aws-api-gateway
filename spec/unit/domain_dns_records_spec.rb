# frozen_string_literal: true

require 'spec_helper'

describe 'DNS records' do
  describe 'by default' do
    before(:context) do
      @api_gateway_rest_api_id =
        output(role: :prerequisites, name: 'api_gateway_rest_api_id')
      @api_gateway_stage_name = 'default'
      @api_gateway_domain_name =
        output(role: :prerequisites, name: 'domain_name')
      @api_gateway_domain_name_certificate_arn =
        output(role: :prerequisites, name: 'certificate_arn')

      @plan = plan(role: :domain) do |vars|
        vars.api_gateway_rest_api_id = @api_gateway_rest_api_id
        vars.api_gateway_stage_name = @api_gateway_stage_name
        vars.api_gateway_domain_name = @api_gateway_domain_name
        vars.api_gateway_domain_name_certificate_arn =
          @api_gateway_domain_name_certificate_arn
      end
    end

    it 'does not create any DNS records' do
      expect(@plan)
        .not_to(include_resource_creation(type: 'aws_route53_record'))
    end
  end

  describe 'when DNS record details provided' do
    before(:context) do
      @api_gateway_rest_api_id =
        output(role: :prerequisites, name: 'api_gateway_rest_api_id')
      @api_gateway_stage_name = 'default'
      @api_gateway_domain_name =
        output(role: :prerequisites, name: 'domain_name')
      @api_gateway_domain_name_certificate_arn =
        output(role: :prerequisites, name: 'certificate_arn')
      @public_zone_id =
        output(role: :prerequisites, name: 'public_zone_id')

      @plan = plan(role: :domain) do |vars|
        vars.api_gateway_rest_api_id = @api_gateway_rest_api_id
        vars.api_gateway_stage_name = @api_gateway_stage_name
        vars.api_gateway_domain_name = @api_gateway_domain_name
        vars.api_gateway_domain_name_certificate_arn =
          @api_gateway_domain_name_certificate_arn
        vars.dns = {
          records: [
            {
              zone_id: @public_zone_id
            }
          ]
        }
      end
    end

    it 'creates a DNS record for each specified record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .once)
    end

    it 'uses a type of A on the created DNS records' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:type, 'A'))
    end

    it 'uses the provided domain name on the created DNS records' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:name, @api_gateway_domain_name))
    end

    it 'uses the provided zone IDs on the created DNS records' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, @public_zone_id))
    end

    it 'evaluates target health on the created DNS records' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(
                [:alias, 0, :evaluate_target_health], true
              ))
    end
  end
end
