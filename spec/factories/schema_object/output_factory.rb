# frozen_string_literal: true

FactoryBot.define do
  factory :output, parent: :schema_object, class: "SBOM::CycloneDX::Output" do
    trait :all_fields
  end
end
