# frozen_string_literal: true

FactoryBot.define do
  factory :advisory, parent: :record, class: "SBOM::CycloneDX::Record::Advisory" do
    url { generate(:url) }

    trait :all_fields do
      title { Faker::Lorem.sentence }
    end
  end
end
