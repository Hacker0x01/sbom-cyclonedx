# frozen_string_literal: true

FactoryBot.define do
  factory :swid, parent: :record, class: "SBOM::CycloneDX::Record::SWID" do
    tag_id { "tag_id" }
    name { "name" }

    trait :all_fields do
      version { Faker::App.semantic_version }
      tag_version { rand(0..100) }
      patch { Faker::Boolean.boolean }
      text { association(:attachment) }
      url { generate(:url) }
    end
  end
end
