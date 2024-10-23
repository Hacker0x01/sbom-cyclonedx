# frozen_string_literal: true

FactoryBot.define do
  factory :data_governance, parent: :schema_object, class: "SBOM::CycloneDX::DataGovernance" do
    trait :all_fields do
      custodians { association_list(:data_governance_responsible_party) }
      stewards { association_list(:data_governance_responsible_party) }
      owners { association_list(:data_governance_responsible_party) }
    end
  end
end
