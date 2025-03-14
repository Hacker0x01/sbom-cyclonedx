# frozen_string_literal: true

FactoryBot.define do
  factory :license_expression, parent: :record, class: "SBOM::CycloneDX::Record::LicenseChoice::LicenseExpression" do
    expression do
      first_license = SBOM::CycloneDX::Enum::LICENSE_ID.sample
      next first_license if Faker::Boolean.boolean

      "#{first_license} #{%w[WITH AND OR].sample} #{SBOM::CycloneDX::Enum::LICENSE_ID.sample}"
    end

    trait :all_fields do
      acknowledgement { SBOM::CycloneDX::Enum::LICENSE_ACKNOWLEDGEMENT.sample }
      bom_ref { generate(:ref_link) }
    end
  end

  factory :wrapped_license, parent: :record, class: "SBOM::CycloneDX::Record::LicenseChoice::WrappedLicense" do
    license

    trait :all_fields
  end
end
