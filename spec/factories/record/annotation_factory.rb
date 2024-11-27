# frozen_string_literal: true

FactoryBot.define do
  factory :annotation, parent: :record, class: "SBOM::CycloneDX::Record::Annotation" do
    subjects { Array.new(rand(1..4)) { generate(:ref_or_cdx_urn) } }
    annotator
    timestamp { Faker::Time.backward(days: 367) }
    text { Faker::Lorem.sentence }

    trait :all_fields do
      bom_ref { generate(:ref_link) }
      annotator
      signature { generate_signature }
    end
  end

  factory :annotator, parent: :record, class: "SBOM::CycloneDX::Record::Annotation::Annotator" do
    transient do
      annotator_type do
        %i[
          organization
          individual
          component
          service
        ].sample
      end
    end

    trait :all_fields

    trait :organization do
      transient { annotator_type { :organization } }
    end

    trait :contact do
      transient { annotator_type { :contact } }
    end

    trait :component do
      transient { annotator_type { :component } }
    end

    trait :service do
      transient { annotator_type { :service } }
    end

    organization do
      annotator_type == :organization ? association(:organizational_entity) : nil
    end

    individual do
      annotator_type == :individual ? association(:organizational_contact) : nil
    end

    component do
      annotator_type == :component ? association(:component) : nil
    end

    service do
      annotator_type == :service ? association(:service) : nil
    end
  end
end
