# frozen_string_literal: true

FactoryBot.define do
  factory :note, parent: :schema_object, class: "SBOM::CycloneDX::Note" do
    text { association(:attachment) }

    trait :all_fields do
      locale { generate(:locale) }
    end
  end
end
