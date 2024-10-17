# frozen_string_literal: true

FactoryBot.define do
  factory :annotation, parent: :schema_object, class: "SBOM::CycloneDX::Annotation" do
    subjects { Array.new(rand(1..4)) { generate(:ref_or_cdx_urn) } }
    annotator
    timestamp { Faker::Time.backward(days: 367) }
    text { Faker::Lorem.sentence }

    trait :all_fields do
      bom_ref { generate(:ref_link) }
      annotator { association(:annotator, :all_fields) }
      signature { association(:signature, :all_fields) }
    end
  end

  factory :annotator, parent: :schema_object, class: "SBOM::CycloneDX::Annotation::Annotator" do
    organization { association(:organizational_entity) }

    trait :organization do
      organization { association(:organizational_entity) }
    end

    trait :individual do
      organization { nil }
      individual { association(:organizational_contact) }
    end

    trait :component do
      organization { nil }
      component
    end

    trait :service do
      organization { nil }
      service
    end
  end
end
