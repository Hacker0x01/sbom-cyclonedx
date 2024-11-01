# frozen_string_literal: true

FactoryBot.define do
  factory :release_notes, parent: :schema_object, class: "SBOM::CycloneDX::ReleaseNotes" do
    type { Faker::Lorem.word }

    trait :all_fields do
      title { Faker::Lorem.sentence }
      featured_image { Faker::LoremFlickr.image }
      social_image { Faker::LoremFlickr.image }
      description { Faker::Lorem.paragraph }
      timestamp { Faker::Time.backward }
      aliases { Array.new(rand(0..3)) { Faker::Lorem.word } }
      tags { Array.new(rand(0..3)) { Faker::Lorem.word } }
      resolves { association_list(:issue) }
      notes { association_list(:note) }
      properties { association_list(:property) }
    end
  end
end
