# frozen_string_literal: true

FactoryBot.define do
  factory :identifiable_action, parent: :schema_object, class: "SBOM::CycloneDX::IdentifiableAction" do
    trait :all_fields
  end
end
