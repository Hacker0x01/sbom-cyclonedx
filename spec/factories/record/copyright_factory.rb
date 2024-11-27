# frozen_string_literal: true

FactoryBot.define do
  factory :copyright, parent: :record, class: "SBOM::CycloneDX::Record::Copyright" do
    text { "©#{rand(1979..2024)} #{Faker::Company.name}" }

    trait :all_fields
  end
end
