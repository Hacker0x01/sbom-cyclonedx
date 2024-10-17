# frozen_string_literal: true

FactoryBot.define do
  factory :declarations, parent: :schema_object, class: "SBOM::CycloneDX::Declarations" do
    trait :all_fields do
      assessors { association_list(:assessor, rand(1..2)) }
      attestations { association_list(:attestation, rand(1..2)) }
      claims { association_list(:claim, rand(1..2)) }
      evidence { association_list(:evidence, rand(1..2)) }
      targets { association_list(:target, rand(1..2)) }
      affirmation
      signature { generate_signature }
    end
  end

  factory :affirmation, parent: :schema_object, class: "SBOM::CycloneDX::Declarations::Affirmation" do
    trait :all_fields do
      statement { Faker::Lorem.sentence }
      signatories { association_list(:signatory, rand(1..2)) }
      signature { generate_signature }
    end
  end

  factory :signatory, parent: :schema_object, class: "SBOM::CycloneDX::Declarations::Affirmation::Signatory" do
    transient do
      signatory_type { %w[signature organization].sample }
    end

    signature { signatory_type == :signature ? generate_signature : nil }
    organization { signatory_type == :organization ? association(:organizational_entity) : nil }
    external_reference { signatory_type == :organization ? association(:external_reference) : nil }

    trait :all_fields do
      name { Faker::Name.name }
      role { Faker::Job.title }
      signature { generate_signature }
      organization factory: :organizational_entity
      external_reference
    end
  end

  factory :assessor, parent: :schema_object, class: "SBOM::CycloneDX::Declarations::Assessor" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      third_party { Faker::Boolean.boolean }
      organization factory: :organizational_entity
    end
  end

  factory :attestation, parent: :schema_object, class: "SBOM::CycloneDX::Declarations::Attestation" do
    trait :all_fields do
      summary { Faker::Lorem.sentence }
      assessor { generate(:ref_link) }
      requirements_map { association_list(:map, rand(1..2)) }
      signature { generate_signature }
    end
  end

  factory :map, parent: :schema_object, class: "SBOM::CycloneDX::Declarations::Attestation::Map" do
    trait :all_fields do
      requirement { generate(:ref_link) }
      claims { Array.new(rand(1..2)) { generate(:ref_link) } }
      counter_claims { Array.new(rand(1..2)) { generate(:ref_link) } }
      conformance
      confidence
    end
  end

  factory :confidence, parent: :schema_object, class: "SBOM::CycloneDX::Declarations::Attestation::Map::Confidence" do
    trait :all_fields do
      score { rand(0.0..1.0) }
      rationale { Faker::Lorem.sentence }
    end
  end

  factory :conformance, parent: :schema_object, class: "SBOM::CycloneDX::Declarations::Attestation::Map::Conformance" do
    trait :all_fields do
      score { rand(0.0..1.0) }
      rationale { Faker::Lorem.sentence }
      mitigation_strategies { Array.new(rand(1..2)) { generate(:ref_link) } }
    end
  end

  factory :claim, parent: :schema_object, class: "SBOM::CycloneDX::Declarations::Claim" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      target { generate(:ref_link) }
      predicate { Faker::Lorem.sentence }
      mitigation_strategies { Array.new(rand(1..2)) { generate(:ref_link) } }
      reasoning { Faker::Lorem.sentence }
      evidence { Array.new(rand(1..2)) { generate(:ref_link) } }
      external_references { Array.new(rand(1..2)) { generate(:ref_link) } }
      signature { generate_signature }
    end
  end

  factory :evidence, parent: :schema_object, class: "SBOM::CycloneDX::Declarations::Claim::Evidence" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      # This will definitely not be valid, but isn't checked currently
      property_name { Faker::Lorem.words(number: 2).join(":").downcase }
      description { Faker::Lorem.sentence }
      data { association_list(:evidence_data, rand(1..2)) }
      created { Faker::Time.backward(days: 367) }
      expires { Faker::Time.between(from: 6.months.ago, to: 18.months.from_now) }
      author factory: :organizational_contact
      reviewer factory: :organizational_contact
      signature { generate_signature }
    end
  end

  factory(
    :evidence_data,
    parent: :schema_object,
    class: "SBOM::CycloneDX::Declarations::Claim::Evidence::EvidenceData"
  ) do
    trait :all_fields do
      name { Faker::Lorem.word }
      contents
      classification { %w[public restricted confidential secret].sample }
      sensitive_data { Array.new(rand(1..3)) { Faker::Lorem.sentence } }
      governance factory: :data_governance
    end
  end

  factory(
    :contents,
    parent: :schema_object,
    class: "SBOM::CycloneDX::Declarations::Claim::Evidence::EvidenceData::Contents"
  ) do
    trait :all_fields do
      attachment
      url { generate(:url) }
    end
  end

  factory :target, parent: :schema_object, class: "SBOM::CycloneDX::Declarations::Target" do
    trait :all_fields do
      organizations { association_list(:organizational_entity, rand(1..2)) }
      components { association_list(:component, rand(1..2)) }
      services { association_list(:service, rand(1..2)) }
    end
  end
end
