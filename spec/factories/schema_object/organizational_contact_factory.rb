# frozen_string_literal: true

FactoryBot.define do
  factory :organizational_contact, parent: :schema_object, class: "SBOM::CycloneDX::OrganizationalContact" do
    trait :all_fields
  end
end
