# frozen_string_literal: true

FactoryBot.define do
  factory :tools, parent: :schema_object, class: "SBOM::CycloneDX::Tools" do
    trait :all_fields
  end
end
