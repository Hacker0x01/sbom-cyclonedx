# frozen_string_literal: true

FactoryBot.define do
  factory :energy_provider, parent: :schema_object, class: "SBOM::CycloneDX::EnergyProvider" do
    trait :all_fields
  end
end
