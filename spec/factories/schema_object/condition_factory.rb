# frozen_string_literal: true

FactoryBot.define do
  factory :condition, parent: :schema_object, class: "SBOM::CycloneDX::Condition" do
    trait :all_fields
  end
end
