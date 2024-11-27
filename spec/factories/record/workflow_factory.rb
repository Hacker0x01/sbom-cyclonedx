# frozen_string_literal: true

FactoryBot.define do
  factory :workflow, parent: :record, class: "SBOM::CycloneDX::Record::Workflow" do
    bom_ref { generate(:ref_link) }
    uid { SecureRandom.uuid }

    trait :all_fields do
      name { Faker::Lorem.word }
      description { Faker::Lorem.sentence }
      resource_references { association_list(:resource_reference_choice) }
      tasks { association_list(:task) }
      task_dependencies { association_list(:dependency) }
      task_types { SBOM::CycloneDX::Enum::TASK_TYPE.sample(rand(1..3)) }
      trigger { association(:trigger) }
      steps { association_list(:step) }
      inputs { association_list(:input) }
      outputs { association_list(:output) }
      time_start { Faker::Time.backward(days: 367) }
      time_end { time_start + rand(1..100).hours }
      workspaces { association_list(:workspace) }
      runtime_topology { association_list(:dependency) }
      properties { association_list(:property) }
    end
  end
end
