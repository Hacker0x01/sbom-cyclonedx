# frozen_string_literal: true

FactoryBot.define do
  factory :graphic, parent: :schema_object, class: "SBOM::CycloneDX::Graphic" do
    trait :all_fields
  end
end
