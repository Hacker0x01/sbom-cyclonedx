# frozen_string_literal: true

FactoryBot.define do
  factory :property, parent: :schema_object, class: "SBOM::CycloneDX::Property" do
    name { Faker::Lorem.word }

    trait :all_fields
  end
end
