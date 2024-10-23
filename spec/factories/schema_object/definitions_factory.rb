# frozen_string_literal: true

FactoryBot.define do
  factory :definitions, parent: :schema_object, class: "SBOM::CycloneDX::Definitions" do
    trait :all_fields do
      standards { association_list(:standard) }
    end
  end
end
