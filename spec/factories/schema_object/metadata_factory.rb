# frozen_string_literal: true

FactoryBot.define do
  factory :metadata, parent: :schema_object, class: "SBOM::CycloneDX::Metadata" do
    trait :all_fields
  end
end
