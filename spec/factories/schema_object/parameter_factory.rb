# frozen_string_literal: true

FactoryBot.define do
  factory :parameter, parent: :schema_object, class: "SBOM::CycloneDX::Parameter" do
    trait :all_fields do
      name { Faker::Lorem.word }
      value { Faker::Lorem.word }
      data_type { Faker::Lorem.word }
    end
  end
end
