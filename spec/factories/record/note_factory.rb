# frozen_string_literal: true

FactoryBot.define do
  factory :note, parent: :record, class: "SBOM::CycloneDX::Record::Note" do
    text { association(:attachment) }

    trait :all_fields do
      locale { generate(:locale) }
    end
  end
end
