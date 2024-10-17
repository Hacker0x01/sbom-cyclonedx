# frozen_string_literal: true

FactoryBot.define do
  factory :postal_address, parent: :schema_object, class: "SBOM::CycloneDX::PostalAddress" do
    trait :all_fields
  end
end
