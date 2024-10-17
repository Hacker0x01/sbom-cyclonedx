# frozen_string_literal: true

FactoryBot.define do
  factory :energy_measure, parent: :schema_object, class: "SBOM::CycloneDX::EnergyMeasure" do
    trait :all_fields
  end
end
