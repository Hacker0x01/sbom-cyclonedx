# frozen_string_literal: true

FactoryBot.define do
  factory :workflow, parent: :schema_object, class: "SBOM::CycloneDX::Workflow" do
    bom_ref { generate(:ref_link) }
    uid { SecureRandom.uuid }

    trait :all_fields
  end
end
