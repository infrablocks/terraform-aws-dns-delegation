# frozen_string_literal: true

require 'spec_helper'

describe 'full' do
  let(:delegated_domain_name) do
    var(role: :full, name: 'delegated_domain_name')
  end

  let(:parent_public_zone_id) do
    output(role: :full, name: 'parent_public_zone_id')
  end
  let(:parent_private_zone_id) do
    output(role: :full, name: 'parent_private_zone_id')
  end

  let(:delegated_public_zone_name_servers) do
    output(role: :full, name: 'delegated_public_zone_name_servers')
  end
  let(:delegated_private_zone_name_servers) do
    output(role: :full, name: 'delegated_private_zone_name_servers')
  end

  before(:context) do
    apply(role: :full)
  end

  after(:context) do
    destroy(
      role: :full,
      only_if: -> { !ENV['FORCE_DESTROY'].nil? || ENV['SEED'].nil? }
    )
  end

  describe 'delegation records' do
    it 'creates a delegation record in the public hosted zone' do
      expect(route53_hosted_zone(parent_public_zone_id))
        .to(have_record_set("#{delegated_domain_name}.")
              .ns(delegated_public_zone_name_servers.join("\n")))
    end

    it 'creates a delegation record in the private hosted zone' do
      expect(route53_hosted_zone(parent_private_zone_id))
        .to(have_record_set("#{delegated_domain_name}.")
              .ns(delegated_private_zone_name_servers.join("\n")))
    end
  end
end
