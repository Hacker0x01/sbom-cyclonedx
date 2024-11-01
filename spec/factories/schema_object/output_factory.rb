# frozen_string_literal: true

FactoryBot.define do
  factory :output, parent: :schema_object, class: "SBOM::CycloneDX::Output" do
    transient do
      reference_type { %i[resource data environment_vars].sample }
    end

    trait :resource do
      reference_type { :resource }
    end

    trait :data do
      reference_type { :data }
    end

    trait :environment_vars do
      reference_type { :environment_vars }
    end

    type { SBOM::CycloneDX::Enum::OUTPUT_TYPE.sample }
    resource { association(:resource_reference_choice) if reference_type == :resource }
    data { association(:attachment) if reference_type == :data }
    environment_vars { association_list(:property) if reference_type == :environment_vars }

    trait :all_fields do
      source { association(:resource_reference_choice) }
      target { association(:resource_reference_choice) }
      properties { association_list(:property) }
    end
  end
end
