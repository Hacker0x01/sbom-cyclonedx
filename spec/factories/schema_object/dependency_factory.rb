# frozen_string_literal: true

FactoryBot.define do
  factory :dependency, parent: :schema_object, class: "SBOM::CycloneDX::Dependency" do
    trait :all_fields
  end
end
