require 'spec_helper'

describe 'delegation records' do
  let(:delegated_domain_name) { vars.delegated_domain_name }

  let(:parent_public_zone_id) { output_for(:prerequisites, 'parent_public_zone_id') }
  let(:parent_private_zone_id) { output_for(:prerequisites, 'parent_private_zone_id') }

  let(:delegated_public_zone_name_servers) {
    output_for(:prerequisites, 'delegated_public_zone_name_servers', parse: true)
  }
  let(:delegated_private_zone_name_servers) {
    output_for(:prerequisites, 'delegated_private_zone_name_servers', parse: true)
  }

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
