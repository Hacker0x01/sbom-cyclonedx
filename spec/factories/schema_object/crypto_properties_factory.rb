# frozen_string_literal: true

FactoryBot.define do
  factory :crypto_properties, parent: :schema_object, class: "SBOM::CycloneDX::CryptoProperties" do
    asset_type { SBOM::CycloneDX::Enum::ASSET_TYPE.sample }

    trait :all_fields
  end
end
