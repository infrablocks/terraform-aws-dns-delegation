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

  describe 'public hosted zone' do
    describe 'when include_public_delegation_record is yes' do
      before(:all) do
        reprovision(include_public_delegation_record: 'yes')
      end

      it 'creates a delegation record in the public hosted zone' do
        expect(route53_hosted_zone(parent_public_zone_id))
            .to(have_record_set("#{delegated_domain_name}.")
                .ns(delegated_public_zone_name_servers.join("\n")))
      end
    end

    describe 'when include_public_delegation_record is no' do
      before(:all) do
        reprovision(include_public_delegation_record: 'no')
      end

      it 'does not create a delegation record in the public hosted zone' do
        expect(route53_hosted_zone(parent_public_zone_id))
            .not_to(have_record_set("#{delegated_domain_name}.")
                .ns(delegated_public_zone_name_servers.join("\n")))
      end
    end
  end

  describe 'private hosted zone' do
    describe 'when include_private_delegation_record is yes' do
      before(:all) do
        reprovision(include_private_delegation_record: 'yes')
      end

      it 'creates a delegation record in the private hosted zone' do
        expect(route53_hosted_zone(parent_private_zone_id))
            .to(have_record_set("#{delegated_domain_name}.")
                .ns(delegated_private_zone_name_servers.join("\n")))
      end
    end

    describe 'when include_private_delegation_record is no' do
      before(:all) do
        reprovision(include_private_delegation_record: 'no')
      end

      it 'does not create a delegation record in the private hosted zone' do
        expect(route53_hosted_zone(parent_private_zone_id))
            .not_to(have_record_set("#{delegated_domain_name}.")
                .ns(delegated_private_zone_name_servers.join("\n")))
      end
    end
  end
end
