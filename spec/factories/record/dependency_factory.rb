# frozen_string_literal: true

FactoryBot.define do
  factory :dependency, parent: :record, class: "SBOM::CycloneDX::Record::Dependency" do
    ref { generate(:ref_link) }

    trait :all_fields do
      depends_on { Array.new(rand(1..3)) { generate(:ref_link) } }
      provides { Array.new(rand(1..3)) { generate(:ref_link) } }
    end
  end
end
