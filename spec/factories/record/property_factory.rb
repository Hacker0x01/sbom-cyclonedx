# frozen_string_literal: true

FactoryBot.define do
  factory :property, parent: :record, class: "SBOM::CycloneDX::Record::Property" do
    name { Faker::Lorem.word }

    trait :all_fields do
      value { Faker::Lorem.word }
    end
  end
end
