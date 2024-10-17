# frozen_string_literal: true

FactoryBot.define do
  factory :service, parent: :schema_object, class: "SBOM::CycloneDX::Service" do
    name { Faker::App.name }

    trait :all_fields
  end
end
