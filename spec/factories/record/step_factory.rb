# frozen_string_literal: true

FactoryBot.define do
  factory :step, parent: :record, class: "SBOM::CycloneDX::Record::Step" do
    trait :all_fields do
      name { Faker::Lorem.word }
      description { Faker::Lorem.sentence }
      commands { association_list(:command) }
      properties { association_list(:property) }
    end
  end
end
