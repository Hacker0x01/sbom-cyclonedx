# frozen_string_literal: true

FactoryBot.define do
  factory :graphic, parent: :record, class: "SBOM::CycloneDX::Record::Graphic" do
    trait :all_fields do
      name { Faker::Lorem.word }
      image { association(:attachment) }
    end
  end
end
