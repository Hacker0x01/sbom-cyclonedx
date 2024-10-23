# frozen_string_literal: true

require "sbom/cyclone_dx/enum"

FactoryBot.define do
  factory :component_identity_evidence, parent: :schema_object, class: "SBOM::CycloneDX::ComponentIdentityEvidence" do
    field { SBOM::CycloneDX::Enum::FIELD.sample }

    trait :all_fields do
      confidence { rand(0.0..1.0) }
      concluded_value { %w[cpe purl omnibor_id swhid swid].sample }
      methods_used { association_list(:method) }
      tools { Array.new(rand(1..4)) { generate(:ref_or_cdx_urn) } }
    end
  end

  factory :method, parent: :schema_object, class: "SBOM::CycloneDX::ComponentIdentityEvidence::Method" do
    technique { Faker::Lorem.word }
    confidence { rand(0.0..1.0) }

    trait :all_fields do
      value { Faker::Lorem.sentence }
    end
  end
end
