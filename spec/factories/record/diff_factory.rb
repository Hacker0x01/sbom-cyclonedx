# frozen_string_literal: true

FactoryBot.define do
  factory :diff, parent: :record, class: "SBOM::CycloneDX::Record::Diff" do
    trait :all_fields do
      text do
        line_count = rand(0..100)
        association(
          :attachment,
          content:
            <<~DIFF_TEXT
              --- #{Faker::Lorem.word}
              +++ #{Faker::Lorem.word}
              @@ -1,#{line_count} +1,#{line_count} @@
              -# #{Faker::Lorem.sentence}
              +# #{Faker::Lorem.sentence}
                #{Faker::Lorem.sentence}
            DIFF_TEXT
        )
      end
      url { generate(:url) }
    end
  end
end
