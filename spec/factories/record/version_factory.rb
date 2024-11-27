# frozen_string_literal: true

FactoryBot.define do
  factory :version, parent: :record, class: "SBOM::CycloneDX::Record::Version" do
    transient do
      version_type { %i[fixed range].sample }
    end

    trait(:fixed) { version_type { :fixed } }
    trait(:range) { version_type { :range } }

    version { Faker::App.semantic_version if version_type == :fixed }
    range { ">=#{Faker::App.semantic_version}" if version_type == :range }

    trait :all_fields do
      status { SBOM::CycloneDX::Enum::AFFECTED_STATUS.sample }
    end
  end
end
