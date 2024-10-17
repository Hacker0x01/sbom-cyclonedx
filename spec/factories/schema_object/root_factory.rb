# frozen_string_literal: true

FactoryBot.define do
  factory :root, parent: :schema_object, class: "SBOM::CycloneDX::Root" do
    trait :all_fields
  end
end
