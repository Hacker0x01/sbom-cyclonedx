# frozen_string_literal: true

FactoryBot.define do
  factory :advisory, parent: :schema_object, class: "SBOM::CycloneDX::Advisory" do
    url { generate(:url) }

    trait :all_fields do
      title { Faker::Lorem.sentence }
    end
  end
end
