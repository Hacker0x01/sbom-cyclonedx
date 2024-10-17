# frozen_string_literal: true

FactoryBot.define do
  factory :declarations, parent: :schema_object, class: "SBOM::CycloneDX::Declarations" do
    trait :all_fields
  end
end
