# frozen_string_literal: true

FactoryBot.define do
  factory :composition, parent: :schema_object, class: "SBOM::CycloneDX::Composition" do
    trait :all_fields
  end
end
