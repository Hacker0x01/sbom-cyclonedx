# frozen_string_literal: true

FactoryBot.define do
  factory :workspace, parent: :record, class: "SBOM::CycloneDX::Record::Workspace" do
    bom_ref { generate(:ref_link) }
    uid { Faker::Lorem.characters(number: 16) }

    trait :all_fields do
      name { Faker::Lorem.word }
      aliases { Faker::Lorem.words(number: rand(1..3)) }
      description { Faker::Lorem.sentence }
      resource_references { association_list(:resource_reference_choice) }
      access_mode { SBOM::CycloneDX::Enum::ACCESS_MODE.sample }
      mount_path { Faker::File.dir }
      managed_data_type { Faker::Lorem.word }
      volume_request { Faker::Lorem.word }
      volume { association(:volume) }
      properties { association_list(:property) }
    end
  end
end
