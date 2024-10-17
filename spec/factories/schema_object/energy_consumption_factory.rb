# frozen_string_literal: true

FactoryBot.define do
  factory :energy_consumption, parent: :schema_object, class: "SBOM::CycloneDX::EnergyConsumption" do
    trait :all_fields
  end
end
