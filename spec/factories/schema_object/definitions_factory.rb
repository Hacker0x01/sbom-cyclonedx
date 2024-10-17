# frozen_string_literal: true

FactoryBot.define do
  factory :definitions, parent: :schema_object, class: "SBOM::CycloneDX::Definitions" do
    trait :all_fields
  end
end
