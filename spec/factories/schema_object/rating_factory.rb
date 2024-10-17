# frozen_string_literal: true

FactoryBot.define do
  factory :rating, parent: :schema_object, class: "SBOM::CycloneDX::Rating" do
    trait :all_fields
  end
end
