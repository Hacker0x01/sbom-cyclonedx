# frozen_string_literal: true

FactoryBot.define do
  factory :component_evidence, parent: :schema_object, class: "SBOM::CycloneDX::ComponentEvidence" do
    trait :all_fields do
      identity { Array.new(rand(1..4)) { association(:component_identity_evidence, :all_fields) } }
      occurrences { Array.new(rand(1..4)) { association(:occurrence, :all_fields) } }
      callstack { association(:callstack, :all_fields) }
      licenses { Array.new(rand(1..4)) { association(%i[license_expression wrapped_license].sample, :all_fields) } }
      copyright { Array.new(rand(1..4)) { association(:copyright, :all_fields) } }
    end
  end

  factory :callstack, parent: :schema_object, class: "SBOM::CycloneDX::ComponentEvidence::Callstack" do
    trait :all_fields do
      frames { Array.new(rand(1..4)) { association(:frame, :all_fields) } }
    end
  end

  factory :frame, parent: :schema_object, class: "SBOM::CycloneDX::ComponentEvidence::Frame" do
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

  factory :occurrence, parent: :schema_object, class: "SBOM::CycloneDX::ComponentEvidence::Occurrence" do
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
