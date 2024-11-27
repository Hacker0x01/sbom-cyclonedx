# frozen_string_literal: true

FactoryBot.define do
  factory :risk, parent: :record, class: "SBOM::CycloneDX::Record::Risk" do
    trait :all_fields do
      name { Faker::Lorem.word }
      mitigation_strategy { Faker::Lorem.sentence }
    end
  end
end
