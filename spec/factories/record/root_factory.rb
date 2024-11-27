# frozen_string_literal: true

FactoryBot.define do
  factory :root, parent: :record, class: "SBOM::CycloneDX::Record::Root" do
    trait :all_fields do
      serial_number { generate(:bom_serial_number) }
      version { rand(1..10_000) }
      metadata { association(:metadata) }
      components { association_list(:component) }
      services { association_list(:service) }
      external_references { association_list(:external_reference) }
      dependencies { association_list(:dependency) }
      compositions { association_list(:composition) }
      vulnerabilities { association_list(:vulnerability) }
      annotations { association_list(:annotation) }
      formulation { association_list(:formula) }
      declarations { association(:declarations) }
      definitions { association(:definitions) }
      properties { association_list(:property) }
      signature { generate_signature }
    end
  end
end
