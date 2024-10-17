# frozen_string_literal: true

FactoryBot.define do
  factory :version, parent: :schema_object, class: "SBOM::CycloneDX::Version" do
    trait :all_fields
  end
end
