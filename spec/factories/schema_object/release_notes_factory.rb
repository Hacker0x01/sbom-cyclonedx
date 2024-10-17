# frozen_string_literal: true

FactoryBot.define do
  factory :release_notes, parent: :schema_object, class: "SBOM::CycloneDX::ReleaseNotes" do
    type { Faker::Lorem.word }

    trait :all_fields
  end
end
