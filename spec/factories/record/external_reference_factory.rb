# frozen_string_literal: true

FactoryBot.define do
  factory :external_reference, parent: :record, class: "SBOM::CycloneDX::Record::ExternalReference" do
    url { generate(:url) }
    type { SBOM::CycloneDX::Enum::EXTERNAL_REFERENCE_TYPE.sample }

    trait :all_fields do
      comment { Faker::Lorem.sentence }
      hashes { association_list(:hash_data) }
    end
  end
end
