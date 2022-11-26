# frozen_string_literal: true

require 'spec_helper'

describe 'role' do
  describe 'by default' do
    before(:context) do
      @plan = plan(role: :log_permissions)
    end

    it 'creates an IAM role' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_role')
              .once)
    end

    it 'uses a role name of "api-gateway-logging-role"' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_role')
              .with_attribute_value(
                :name, 'api-gateway-logging-role'
              ))
    end

    it 'allows API gateway to assume the role' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_role')
              .with_attribute_value(
                :assume_role_policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Action: 'sts:AssumeRole',
                  Principal: {
                    Service: 'apigateway.amazonaws.com'
                  }
                )
              ))
    end

    it 'creates an IAM policy' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_role_policy')
              .once)
    end

    it 'uses a role policy name of "api-gateway-logging-policy"' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_role_policy')
              .with_attribute_value(
                :name, 'api-gateway-logging-policy'
              ))
    end

    it 'allows API gateway to manage logging' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_role_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Action: %w[
                    logs:CreateLogGroup
                    logs:CreateLogStream
                    logs:DescribeLogGroups
                    logs:DescribeLogStreams
                    logs:PutLogEvents
                    logs:GetLogEvents
                    logs:FilterLogEvents
                  ],
                  Resource: '*'
                )
              ))
    end

    it 'outputs the logging role ID' do
      expect(@plan)
        .to(include_output_creation(name: 'logging_role_id'))
    end

    it 'outputs the logging role ARN' do
      expect(@plan)
        .to(include_output_creation(name: 'logging_role_arn'))
    end

    it 'outputs the logging role name' do
      expect(@plan)
        .to(include_output_creation(name: 'logging_role_name'))
    end

    it 'outputs the logging role policy ID' do
      expect(@plan)
        .to(include_output_creation(name: 'logging_role_policy_id'))
    end

    it 'outputs the logging role policy name' do
      expect(@plan)
        .to(include_output_creation(name: 'logging_role_policy_name'))
    end
  end
end
