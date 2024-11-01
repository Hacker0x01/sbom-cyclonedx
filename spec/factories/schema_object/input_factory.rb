# frozen_string_literal: true

FactoryBot.define do
  factory :input, parent: :schema_object, class: "SBOM::CycloneDX::Input" do
    transient do
      input_type { %i[resource parameters environment_vars data].sample }
    end

    trait :resource do
      input_type { :resource }
    end

    trait :parameters do
      input_type { :parameters }
    end

    trait :environment_vars do
      input_type { :environment_vars }
    end

    trait :data do
      input_type { :data }
    end

    resource { input_type == :resource ? association(:resource_reference_choice) : nil }
    parameters { input_type == :parameters ? association_list(:parameter) : nil }
    environment_vars { input_type == :environment_vars ? association_list(:property) : nil }
    data { input_type == :data ? association(:attachment) : nil }

    trait :all_fields do
      source { association(:resource_reference_choice) }
      target { association(:resource_reference_choice) }
      properties { association_list(:property) }
    end
  end
end
