# frozen_string_literal: true

FactoryBot.define do
  factory :copyright, parent: :schema_object, class: "SBOM::CycloneDX::Copyright" do
    text { "©#{rand(1979..2024)} #{Faker::Company.name}" }

    trait :all_fields
  end
end
