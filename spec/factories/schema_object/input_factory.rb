# frozen_string_literal: true

FactoryBot.define do
  factory :input, parent: :schema_object, class: "SBOM::CycloneDX::Input" do
    trait :all_fields
  end
end
