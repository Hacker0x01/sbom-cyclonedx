# frozen_string_literal: true

FactoryBot.define do
  factory :resource_reference_choice, parent: :schema_object, class: "SBOM::CycloneDX::ResourceReferenceChoice" do
    trait :all_fields
  end
end
