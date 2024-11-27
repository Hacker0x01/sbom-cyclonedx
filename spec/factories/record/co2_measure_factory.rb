# frozen_string_literal: true

FactoryBot.define do
  factory :co2_measure, parent: :record, class: "SBOM::CycloneDX::Record::CO2Measure" do
    value { rand(0.0..100.0) }

    trait :all_fields
  end
end
