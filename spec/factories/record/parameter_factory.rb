# frozen_string_literal: true

FactoryBot.define do
  factory :parameter, parent: :record, class: "SBOM::CycloneDX::Record::Parameter" do
    trait :all_fields do
      name { Faker::Lorem.word }
      value { Faker::Lorem.word }
      data_type { Faker::Lorem.word }
    end
  end
end
