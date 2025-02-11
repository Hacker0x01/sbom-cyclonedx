# frozen_string_literal: true

FactoryBot.define do
  factory :component_evidence, parent: :record, class: "SBOM::CycloneDX::Record::ComponentEvidence" do
    trait :all_fields do
      identity { association_list(:component_identity_evidence) }
      occurrences { association_list(:occurrence) }
      callstack
      licenses { license_choice_list(rand(1..3)) }
      copyright { association_list(:copyright) }
    end
  end

  factory :callstack, parent: :record, class: "SBOM::CycloneDX::Record::ComponentEvidence::Callstack" do
    trait :all_fields do
      frames { association_list(:frame) }
    end
  end

  factory :frame, parent: :record, class: "SBOM::CycloneDX::Record::ComponentEvidence::Frame" do
    source_module { Faker::Lorem.word }

    trait :all_fields do
      package { Faker::Lorem.word }
      function { Faker::Lorem.word }
      parameters { Faker::Lorem.words(number: rand(1..4)) }
      line { rand(1..1000) }
      column { rand(1..200) }
      full_filename { Faker::File.file_name }
    end
  end

  factory :occurrence, parent: :record, class: "SBOM::CycloneDX::Record::ComponentEvidence::Occurrence" do
    location { Faker::File.file_name }

    trait :all_fields do
      bom_ref { generate(:ref_link) }
      line { rand(1..1000) }
      offset { rand(1..200) }
      symbol { Faker::Lorem.word }
      additional_context { Faker::Lorem.sentence }
    end
  end
end
