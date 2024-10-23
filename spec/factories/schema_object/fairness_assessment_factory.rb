# frozen_string_literal: true

FactoryBot.define do
  factory :fairness_assessment, parent: :schema_object, class: "SBOM::CycloneDX::FairnessAssessment" do
    trait :all_fields do
      group_at_risk { Faker::Lorem.word }
      benefits { Faker::Lorem.words(number: rand(0..4)).join(", ") }
      harms { Faker::Lorem.words(number: rand(0..4)).join(", ") }
      mitigation_strategy { Faker::Lorem.sentence }
    end
  end
end
