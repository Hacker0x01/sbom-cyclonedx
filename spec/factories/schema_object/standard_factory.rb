# frozen_string_literal: true

FactoryBot.define do
  factory :standard, parent: :schema_object, class: "SBOM::CycloneDX::Standard" do
    trait :all_fields
  end
end
