# frozen_string_literal: true

FactoryBot.define do
  factory :workspace, parent: :schema_object, class: "SBOM::CycloneDX::Workspace" do
    trait :all_fields
  end
end
