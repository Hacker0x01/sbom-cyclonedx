# frozen_string_literal: true

FactoryBot.define do
  factory :performance_metric, parent: :record, class: "SBOM::CycloneDX::Record::PerformanceMetric" do
    trait :all_fields do
      type { Faker::Lorem.word }
      value { Faker::Lorem.word }
      slice { Faker::Lorem.word }
      confidence_interval { association(:confidence_interval) }
    end
  end

  factory :confidence_interval, parent: :record,
                                class: "SBOM::CycloneDX::Record::PerformanceMetric::ConfidenceInterval" do
    trait :all_fields do
      lower_bound { Faker::Lorem.word }
      upper_bound { Faker::Lorem.word }
    end
  end
end
