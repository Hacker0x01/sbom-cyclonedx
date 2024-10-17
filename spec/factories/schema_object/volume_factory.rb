# frozen_string_literal: true

FactoryBot.define do
  factory :volume, parent: :schema_object, class: "SBOM::CycloneDX::Volume" do
    trait :all_fields
  end
end
