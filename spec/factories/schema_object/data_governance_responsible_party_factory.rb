# frozen_string_literal: true

FactoryBot.define do
  factory :data_governance_responsible_party, parent: :schema_object,
                                              class: "SBOM::CycloneDX::DataGovernanceResponsibleParty" do
    trait :all_fields
  end
end
