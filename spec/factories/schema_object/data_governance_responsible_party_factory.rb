# frozen_string_literal: true

FactoryBot.define do
  factory(
    :data_governance_responsible_party,
    parent: :schema_object,
    class: "SBOM::CycloneDX::DataGovernanceResponsibleParty"
  ) do
    transient do
      party_type { %i[organization contact].sample }
    end

    trait :all_fields

    trait :organization do
      transient { party_type { :organization } }
    end

    trait :contact do
      transient { party_type { :contact } }
    end

    organization do
      party_type == :organization ? association(:organizational_entity) : nil
    end

    contact do
      party_type == :contact ? association(:organizational_contact) : nil
    end
  end
end
