# frozen_string_literal: true

FactoryBot.define do
  factory :hash_data, parent: :schema_object, class: "SBOM::CycloneDX::HashData" do
    alg { SBOM::CycloneDX::Enum::HASH_ALG.sample }
    content { generate(:hash_value) }

    trait :all_fields
  end
end
