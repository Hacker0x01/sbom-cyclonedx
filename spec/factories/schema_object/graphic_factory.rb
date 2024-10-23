# frozen_string_literal: true

FactoryBot.define do
  factory :graphic, parent: :schema_object, class: "SBOM::CycloneDX::Graphic" do
    trait :all_fields do
      name { Faker::Lorem.word }
      image { association(:attachment) }
    end
  end
end
