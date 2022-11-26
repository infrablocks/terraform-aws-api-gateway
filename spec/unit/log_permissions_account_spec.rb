# frozen_string_literal: true

require 'spec_helper'

describe 'account' do
  describe 'by default' do
    before(:context) do
      @plan = plan(role: :log_permissions)
    end

    it 'creates an API gateway account configuration resource' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_api_gateway_account')
              .once)
    end
  end
end
