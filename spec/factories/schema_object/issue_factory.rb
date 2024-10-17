# frozen_string_literal: true

FactoryBot.define do
  factory :issue, parent: :schema_object, class: "SBOM::CycloneDX::Issue" do
    trait :all_fields
  end
end
