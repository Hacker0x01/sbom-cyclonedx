# frozen_string_literal: true

FactoryBot.define do
  factory :step, parent: :schema_object, class: "SBOM::CycloneDX::Step" do
    trait :all_fields
  end
end
