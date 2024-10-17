# frozen_string_literal: true

FactoryBot.define do
  factory :event, parent: :schema_object, class: "SBOM::CycloneDX::Event" do
    trait :all_fields
  end
end
