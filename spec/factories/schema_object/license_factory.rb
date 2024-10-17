# frozen_string_literal: true

FactoryBot.define do
  factory :license, parent: :schema_object, class: "SBOM::CycloneDX::License" do
    id { SBOM::CycloneDX::Enum::LICENSE_ID.sample }

    trait :all_fields
  end
end
