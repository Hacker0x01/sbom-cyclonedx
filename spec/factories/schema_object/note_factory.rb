# frozen_string_literal: true

FactoryBot.define do
  factory :note, parent: :schema_object, class: "SBOM::CycloneDX::Note" do
    trait :all_fields
  end
end
