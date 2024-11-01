# frozen_string_literal: true

FactoryBot.define do
  factory :service, parent: :schema_object, class: "SBOM::CycloneDX::Service" do
    name { Faker::App.name }

    trait :all_fields do
      bom_ref { generate(:ref_link) }
      provider { association :organizational_entity }
      group { Faker::Lorem.word }
      version { Faker::App.semantic_version }
      description { Faker::Lorem.sentence }
      endpoints { Array.new(rand(0..3)) { generate(:url) } }
      authenticated { Faker::Boolean.boolean }
      x_trust_boundary { Faker::Boolean.boolean }
      trust_zone { Faker::Lorem.word }
      data { association_list(:service_data) }
      licenses { license_choice_list }
      external_references { association_list(:external_reference) }
      services { association_list(:service) }
      release_notes { association :release_notes }
      properties { association_list(:property) }
      tags { Array.new(rand(0..3)) { Faker::Lorem.word } }
      signature { generate_signature }
    end
  end
end
