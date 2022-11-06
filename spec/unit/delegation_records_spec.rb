# frozen_string_literal: true

require 'spec_helper'

describe 'delegation records' do
  let(:delegated_domain_name) do
    var(role: :root, name: 'delegated_domain_name')
  end

  let(:parent_public_zone_id) do
    output(role: :prerequisites, name: 'parent_public_zone_id')
  end
  let(:parent_private_zone_id) do
    output(role: :prerequisites, name: 'parent_private_zone_id')
  end

  let(:delegated_public_zone_name_servers) do
    output(role: :prerequisites, name: 'delegated_public_zone_name_servers')
  end
  let(:delegated_private_zone_name_servers) do
    output(role: :prerequisites, name: 'delegated_private_zone_name_servers')
  end

  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root)
    end

    it 'creates a public NS record in the parent public zone' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_public_zone_id)
              .once)
    end

    it 'uses the provided delegated domain name on the public NS record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_public_zone_id)
              .with_attribute_value(:name, delegated_domain_name))
    end

    it 'uses a TTL of 172800 on the public NS record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_public_zone_id)
              .with_attribute_value(:ttl, 172_800))
    end

    it 'uses the provided delegated zone name servers on the public NS ' \
       'record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_public_zone_id)
              .with_attribute_value(
                :records, delegated_public_zone_name_servers
              ))
    end

    it 'creates a private NS record in the parent private zone' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_private_zone_id)
              .once)
    end

    it 'uses the provided delegated domain name on the private NS record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_private_zone_id)
              .with_attribute_value(:name, delegated_domain_name))
    end

    it 'uses a TTL of 172800 on the private NS record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_private_zone_id)
              .with_attribute_value(:ttl, 172_800))
    end

    it 'uses the provided delegated zone name servers on the private NS ' \
       'record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_private_zone_id)
              .with_attribute_value(
                :records, delegated_private_zone_name_servers
              ))
    end
  end

  describe 'when ttl is provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.ttl = 86_400
      end
    end

    it 'uses the provided TTL on the public NS record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_public_zone_id)
              .with_attribute_value(:ttl, 86_400))
    end

    it 'uses the provided TTL on the private NS record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_private_zone_id)
              .with_attribute_value(:ttl, 86_400))
    end
  end

  describe 'when include_public_delegation_record is "no"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.include_public_delegation_record = 'no'
      end
    end

    it 'does not create a public NS record in the parent public zone' do
      expect(@plan)
        .not_to(include_resource_creation(type: 'aws_route53_record')
                  .with_attribute_value(:zone_id, parent_public_zone_id)
                  .once)
    end
  end

  describe 'when include_public_delegation_record is "yes"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.include_public_delegation_record = 'yes'
      end
    end

    it 'creates a public NS record in the parent public zone' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_public_zone_id)
              .once)
    end

    it 'uses the provided delegated domain name on the public NS record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_public_zone_id)
              .with_attribute_value(:name, delegated_domain_name))
    end

    it 'uses a TTL of 172800 on the public NS record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_public_zone_id)
              .with_attribute_value(:ttl, 172_800))
    end

    it 'uses the provided delegated zone name servers on the public NS ' \
       'record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_public_zone_id)
              .with_attribute_value(
                :records, delegated_public_zone_name_servers
              ))
    end
  end

  describe 'when include_private_delegation_record is "no"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.include_private_delegation_record = 'no'
      end
    end

    it 'does not create a private NS record in the parent private zone' do
      expect(@plan)
        .not_to(include_resource_creation(type: 'aws_route53_record')
                  .with_attribute_value(:zone_id, parent_private_zone_id)
                  .once)
    end
  end

  describe 'when include_private_delegation_record is "yes"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.include_private_delegation_record = 'yes'
      end
    end

    it 'creates a private NS record in the parent private zone' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_private_zone_id)
              .once)
    end

    it 'uses the provided delegated domain name on the private NS record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_private_zone_id)
              .with_attribute_value(:name, delegated_domain_name))
    end

    it 'uses a TTL of 172800 on the private NS record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_private_zone_id)
              .with_attribute_value(:ttl, 172_800))
    end

    it 'uses the provided delegated zone name servers on the private NS ' \
       'record' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_route53_record')
              .with_attribute_value(:zone_id, parent_private_zone_id)
              .with_attribute_value(
                :records, delegated_private_zone_name_servers
              ))
    end
  end
end
