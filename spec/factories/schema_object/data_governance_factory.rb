# frozen_string_literal: true

FactoryBot.define do
  factory :data_governance, parent: :schema_object, class: "SBOM::CycloneDX::DataGovernance" do
    trait :all_fields
  end
end
