# frozen_string_literal: true

FactoryBot.define do
  factory :model_card, parent: :schema_object, class: "SBOM::CycloneDX::ModelCard" do
    trait :all_fields
  end
end
