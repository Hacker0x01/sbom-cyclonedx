# frozen_string_literal: true

FactoryBot.define do
  factory :volume, parent: :schema_object, class: "SBOM::CycloneDX::Volume" do
    trait :all_fields do
      uid { Faker::Lorem.characters(number: 16) }
      name { Faker::Lorem.word }
      mode { SBOM::CycloneDX::Enum::VOLUME_MODE.sample }
      path { Faker::File.dir }
      size_allocated { "#{rand(0..1023)}#{["", "K", "M", "G", "T", "P"].sample}B" }
      persistent { Faker::Boolean.boolean }
      remote { Faker::Boolean.boolean }
      properties { association_list(:property) }
    end
  end
end
