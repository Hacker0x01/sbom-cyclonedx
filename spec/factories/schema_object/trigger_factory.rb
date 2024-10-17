# frozen_string_literal: true

FactoryBot.define do
  factory :trigger, parent: :schema_object, class: "SBOM::CycloneDX::Trigger" do
    trait :all_fields
  end
end
