# frozen_string_literal: true

FactoryBot.define do
  factory :environmental_consideration, parent: :schema_object, class: "SBOM::CycloneDX::EnvironmentalConsideration" do
    trait :all_fields
  end
end
