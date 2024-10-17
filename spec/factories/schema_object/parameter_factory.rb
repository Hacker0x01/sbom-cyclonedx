# frozen_string_literal: true

FactoryBot.define do
  factory :parameter, parent: :schema_object, class: "SBOM::CycloneDX::Parameter" do
    trait :all_fields
  end
end
