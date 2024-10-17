# frozen_string_literal: true

FactoryBot.define do
  factory :workflow, parent: :schema_object, class: "SBOM::CycloneDX::Workflow" do
    trait :all_fields
  end
end
