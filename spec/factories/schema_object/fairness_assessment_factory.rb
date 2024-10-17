# frozen_string_literal: true

FactoryBot.define do
  factory :fairness_assessment, parent: :schema_object, class: "SBOM::CycloneDX::FairnessAssessment" do
    trait :all_fields
  end
end
