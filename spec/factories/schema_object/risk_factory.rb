# frozen_string_literal: true

FactoryBot.define do
  factory :risk, parent: :schema_object, class: "SBOM::CycloneDX::Risk" do
    trait :all_fields
  end
end
