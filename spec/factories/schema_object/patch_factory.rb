# frozen_string_literal: true

FactoryBot.define do
  factory :patch, parent: :schema_object, class: "SBOM::CycloneDX::Patch" do
    type { SBOM::CycloneDX::Enum::PATCH_TYPE.sample }

    trait :all_fields
  end
end
