# frozen_string_literal: true

FactoryBot.define do
  factory :energy_measure, parent: :record, class: "SBOM::CycloneDX::Record::EnergyMeasure" do
    value { Faker::Number.decimal(l_digits: 2) }

    trait :all_fields
  end
end
