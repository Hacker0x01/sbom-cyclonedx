# frozen_string_literal: true

FactoryBot.define do
  factory :composition, parent: :schema_object, class: "SBOM::CycloneDX::Composition" do
    trait :all_fields do
      bom_ref { generate(:ref_link) }
      aggregate { SBOM::CycloneDX::Enum::AGGREGATE_TYPE.sample }
      assemblies { Array.new(rand(1..3)) { generate(:ref_or_cdx_urn) } }
      dependencies do
        Array.new(rand(1..3)) do
          next association(:component) if Faker::Boolean.boolean

          association(:service)
        end
      end
      vulnerabilities { association_list(:vulnerability, rand(1..3)) }
      signature { generate_signature }
    end
  end
end
