# frozen_string_literal: true

FactoryBot.define do
  factory :declarations, parent: :record, class: "SBOM::CycloneDX::Record::Declarations" do
    trait :all_fields do
      assessors { association_list(:assessor) }
      attestations { association_list(:attestation) }
      claims { association_list(:claim) }
      evidence { association_list(:evidence) }
      targets { association_list(:target) }
      affirmation
      signature { generate_signature }
    end
  end

  factory :affirmation, parent: :record, class: "SBOM::CycloneDX::Record::Declarations::Affirmation" do
    trait :all_fields do
      statement { Faker::Lorem.sentence }
      signatories { association_list(:signatory) }
      signature { generate_signature }
    end
  end

  factory :signatory, parent: :record, class: "SBOM::CycloneDX::Record::Declarations::Affirmation::Signatory" do
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

  factory :assessor, parent: :record, class: "SBOM::CycloneDX::Record::Declarations::Assessor" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      third_party { Faker::Boolean.boolean }
      organization factory: :organizational_entity
    end
  end

  factory :attestation, parent: :record, class: "SBOM::CycloneDX::Record::Declarations::Attestation" do
    trait :all_fields do
      summary { Faker::Lorem.sentence }
      assessor { generate(:ref_link) }
      requirements_map { association_list(:map) }
      signature { generate_signature }
    end
  end

  factory :map, parent: :record, class: "SBOM::CycloneDX::Record::Declarations::Attestation::Map" do
    trait :all_fields do
      requirement { generate(:ref_link) }
      claims { Array.new(rand(1..2)) { generate(:ref_link) } }
      counter_claims { Array.new(rand(1..2)) { generate(:ref_link) } }
      conformance
      confidence
    end
  end

  factory :confidence, parent: :record, class: "SBOM::CycloneDX::Record::Declarations::Attestation::Map::Confidence" do
    trait :all_fields do
      score { rand(0.0..1.0) }
      rationale { Faker::Lorem.sentence }
    end
  end

  factory :conformance, parent: :record,
                        class: "SBOM::CycloneDX::Record::Declarations::Attestation::Map::Conformance" do
    trait :all_fields do
      score { rand(0.0..1.0) }
      rationale { Faker::Lorem.sentence }
      mitigation_strategies { Array.new(rand(1..2)) { generate(:ref_link) } }
    end
  end

  factory :claim, parent: :record, class: "SBOM::CycloneDX::Record::Declarations::Claim" do
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

  factory :evidence, parent: :record, class: "SBOM::CycloneDX::Record::Declarations::Evidence" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      # This will definitely not be valid, but isn't checked currently
      property_name { Faker::Lorem.words(number: 2).join(":").downcase }
      description { Faker::Lorem.sentence }
      data { association_list(:evidence_data) }
      created { Faker::Time.backward(days: 367) }
      expires { Faker::Time.between(from: 6.months.ago, to: 18.months.from_now) }
      author factory: :organizational_contact
      reviewer factory: :organizational_contact
      signature { generate_signature }
    end
  end

  factory(
    :evidence_data,
    parent: :record,
    class: "SBOM::CycloneDX::Record::Declarations::Evidence::EvidenceData"
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
    parent: :record,
    class: "SBOM::CycloneDX::Record::Declarations::Evidence::EvidenceData::Contents"
  ) do
    trait :all_fields do
      attachment
      url { generate(:url) }
    end
  end

  factory :target, parent: :record, class: "SBOM::CycloneDX::Record::Declarations::Target" do
    trait :all_fields do
      organizations { association_list(:organizational_entity) }
      components { association_list(:component) }
      services { association_list(:service) }
    end
  end
end
