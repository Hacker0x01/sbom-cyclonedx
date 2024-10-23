# frozen_string_literal: true

FactoryBot.define do
  factory :condition, parent: :schema_object, class: "SBOM::CycloneDX::Condition" do
    trait :all_fields do
      description { Faker::Lorem.sentence }
      expression { Faker::Lorem.words(number: 4).zip(Array.new(3) { %w[AND OR XOR].sample }).flatten.join(" ") }
      properties { association_list(:property).sample }
    end
  end
end
