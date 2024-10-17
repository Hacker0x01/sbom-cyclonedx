# frozen_string_literal: true

require "sbom/cyclone_dx/enum"

FactoryBot.define do
  factory :component_data, parent: :schema_object, class: "SBOM::CycloneDX::ComponentData" do
    type { SBOM::CycloneDX::Enum::COMPONENT_DATA_TYPE.sample }

    trait :all_fields do
      bom_ref { generate(:ref_link) }
      name { Faker::Lorem.word }
      contents { association(:content, :all_fields) }
      classification { Faker::Lorem.word }
      sensitive_data { Array.new(rand(1..4)) { Faker::Lorem.word } }
      graphics { association(:graphics_collection, :all_fields) }
      description { Faker::Lorem.sentence }
      governance { association(:data_governance, :all_fields) }
    end
  end

  factory :content, parent: :schema_object, class: "SBOM::CycloneDX::ComponentData::Content" do
    trait :all_fields do
      attachment { association(:attachment, :all_fields) }
      url { generate(:url) }
      properties { Array.new(rand(1..4)) { association(:property, :all_fields) } }
    end
  end
end
