# frozen_string_literal: true

FactoryBot.define do
  factory :formula, parent: :schema_object, class: "SBOM::CycloneDX::Formula" do
    trait :all_fields
  end
end
