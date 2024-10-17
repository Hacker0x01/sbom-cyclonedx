# frozen_string_literal: true

FactoryBot.define do
  factory :swid, parent: :schema_object, class: "SBOM::CycloneDX::SWID" do
    tag_id { "tag_id" }
    name { "name" }

    trait :all_fields
  end
end
