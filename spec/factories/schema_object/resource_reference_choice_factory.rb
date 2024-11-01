# frozen_string_literal: true

FactoryBot.define do
  factory :resource_reference_choice, parent: :schema_object, class: "SBOM::CycloneDX::ResourceReferenceChoice" do
    transient do
      reference_type { %i[ref external_reference].sample }
    end

    trait :ref do
      transient { reference_type { :ref } }
    end

    trait :external_reference do
      transient { reference_type { :external_reference } }
    end

    ref do
      reference_type == :ref ? generate(:ref_or_cdx_urn) : nil
    end

    external_reference do
      reference_type == :external_reference ? association(:external_reference) : nil
    end

    trait :all_fields
  end
end
