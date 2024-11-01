# frozen_string_literal: true

FactoryBot.define do
  factory :service_data, parent: :schema_object, class: "SBOM::CycloneDX::ServiceData" do
    flow { SBOM::CycloneDX::Enum::DATA_FLOW_DIRECTION.sample }
    classification { Faker::Lorem.word }
    source { Faker::Boolean.boolean ? generate(:url) : generate(:cdx_urn) }
    destination { Faker::Boolean.boolean ? generate(:url) : generate(:cdx_urn) }

    trait :all_fields do
      name { Faker::Lorem.word }
      description { Faker::Lorem.sentence }
      governance { association(:data_governance) }
    end
  end
end
