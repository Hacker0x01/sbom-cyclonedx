# frozen_string_literal: true

require "sbom/cyclone_dx/enum"

FactoryBot.define do
  factory :component_data, parent: :schema_object, class: "SBOM::CycloneDX::ComponentData" do
    type { SBOM::CycloneDX::Enum::COMPONENT_DATA_TYPE.sample }

    trait :all_fields do
      bom_ref { generate(:ref_link) }
      name { Faker::Lorem.word }
      contents factory: :content
      classification { Faker::Lorem.word }
      sensitive_data { Array.new(rand(1..4)) { Faker::Lorem.word } }
      graphics factory: :graphics_collection
      description { Faker::Lorem.sentence }
      governance factory: :data_governance
    end
  end

  factory :content, parent: :schema_object, class: "SBOM::CycloneDX::ComponentData::Content" do
    trait :all_fields do
      attachment
      url { generate(:url) }
      properties { association_list(:property) }
    end
  end
end
