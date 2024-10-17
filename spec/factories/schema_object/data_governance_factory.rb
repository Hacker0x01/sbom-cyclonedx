# frozen_string_literal: true

FactoryBot.define do
  factory :data_governance, parent: :schema_object, class: "SBOM::CycloneDX::DataGovernance" do
    trait :all_fields do
      custodians { association_list(:data_governance_responsible_party, rand(1..3)) }
      stewards { association_list(:data_governance_responsible_party, rand(1..3)) }
      owners { association_list(:data_governance_responsible_party, rand(1..3)) }
    end
  end
end
