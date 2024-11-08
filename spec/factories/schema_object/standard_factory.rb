# frozen_string_literal: true

FactoryBot.define do
  factory :standard, parent: :schema_object, class: "SBOM::CycloneDX::Standard" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      name { Faker::Lorem.word }
      version { Faker::App.semantic_version }
      description { Faker::Lorem.sentence }
      owner { Faker::Company.name }
      requirements { association_list(:requirement) }
      levels { association_list(:level) }
      external_references { association_list(:external_reference) }
      signature { generate_signature }
    end
  end

  factory :level, parent: :schema_object, class: "SBOM::CycloneDX::Standard::Level" do
    bom_ref { generate(:ref_link) }
    identifier { Faker::Lorem.word }
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    requirements { Array.new(rand(0..2)) { generate(:ref_link) } }
  end

  factory :requirement, parent: :schema_object, class: "SBOM::CycloneDX::Standard::Requirement" do
    bom_ref { generate(:ref_link) }
    identifier { Faker::Lorem.word }
    title { Faker::Lorem.word }
    text { Faker::Lorem.paragraph }
    descriptions { Array.new(rand(0..2)) { Faker::Lorem.sentence } }
    open_cre { Array.new(rand(0..3)) { generate(:open_cre) } }
    parent { generate(:ref_link) }
    properties { association_list(:property) }
    external_references { association_list(:external_reference) }
  end
end
