# frozen_string_literal: true

FactoryBot.define do
  factory :rating, parent: :record, class: "SBOM::CycloneDX::Record::Rating" do
    trait :all_fields do
      source { association(:vulnerability_source) }
      score { rand(0.0..10.0) }
      severity { SBOM::CycloneDX::Enum::SEVERITY.sample }
      score_method { SBOM::CycloneDX::Enum::SCORE_METHOD.sample }
      vector { Faker::Lorem.sentence }
      justification { Faker::Lorem.sentence }
    end
  end
end
