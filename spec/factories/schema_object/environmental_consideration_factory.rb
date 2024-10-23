# frozen_string_literal: true

FactoryBot.define do
  factory :environmental_consideration, parent: :schema_object, class: "SBOM::CycloneDX::EnvironmentalConsideration" do
    trait :all_fields do
      energy_consumptions { association_list(:energy_consumption) }
      properties { association_list(:property) }
    end
  end
end
