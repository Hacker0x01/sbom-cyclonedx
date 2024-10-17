# frozen_string_literal: true

FactoryBot.define do
  factory :copyright, parent: :schema_object, class: "SBOM::CycloneDX::Copyright" do
    text { Faker::Lorem.sentence }

    trait :all_fields
  end
end
