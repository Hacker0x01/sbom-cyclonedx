# frozen_string_literal: true

FactoryBot.define do
  factory :hash_data, parent: :record, class: "SBOM::CycloneDX::Record::HashData" do
    alg { SBOM::CycloneDX::Enum::HASH_ALG.sample }
    content { generate(:hash_value) }

    trait :all_fields
  end
end
