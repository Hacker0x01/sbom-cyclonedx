# frozen_string_literal: true

FactoryBot.define do
  factory :secured_by, parent: :schema_object, class: "SBOM::CycloneDX::SecuredBy" do
    trait :all_fields do
      mechanism { Faker::Lorem.word }
      algorithm_ref { generate(:ref_link) }
    end
  end
end
