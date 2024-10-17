# frozen_string_literal: true

FactoryBot.define do
  factory :diff, parent: :schema_object, class: "SBOM::CycloneDX::Diff" do
    trait :all_fields
  end
end
