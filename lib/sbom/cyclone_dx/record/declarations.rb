# frozen_string_literal: true

require_relative "../pattern"
require_relative "base"

# Declarations - The list of declarations which describe the conformance to standards. Each declaration may include attestations, claims, and evidence.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Declarations
      class Declarations < Base
        # Schema name: Affirmation
        class Affirmation < Base
          # Schema name: Signatory
          class Signatory < Base
            # Name - The signatory's name.
            prop :name, :string
            # Role - The signatory's role within an organization.
            prop :role, :string
            # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
            prop :signature, :union, of: Signature::UNION_TYPE
            # Organization - The signatory's organization.
            prop :organization, OrganizationalEntity
            # External Reference - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
            prop :external_reference, ExternalReference

            validate(
              :signature,
              :organization,
              :external_reference,
              message: "must specify organization and external_reference if signature is not provided"
            ) do |signature, organization, external_reference|
              signature.nil? && (organization.nil? || external_reference.nil?)
            end
          end

          # Statement - The brief statement affirmed by an individual regarding all declarations.\n*- Notes This could be an affirmation of acceptance by a third-party auditor or receiving individual of a file.
          # Example: "I certify, to the best of my knowledge, that all information is correct."
          prop :statement, :string
          # Signatories - The list of signatories authorized on behalf of an organization to assert validity of this document.
          prop :signatories, :array, items: Signatory
          # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
          prop :signature, :union, of: Signature::UNION_TYPE
        end

        # Schema name: Assessor
        class Assessor < Base
          # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
          prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
          # Third Party - The boolean indicating if the assessor is outside the organization generating claims. A value of false indicates a self assessor.
          prop :third_party, :boolean
          # Organization - The entity issuing the assessment.
          prop :organization, OrganizationalEntity
        end

        # Schema name: Attestation
        class Attestation < Base
          # Schema name: Map
          class Map < Base
            # Schema name: Confidence
            class Confidence < Base
              # Score - The confidence of the claim between and inclusive of 0 and 1, where 1 is 100% confidence.
              prop :score, :float, minimum: 0, maximum: 1
              # Rationale - The rationale for the confidence score.
              prop :rationale, :string
            end

            # Schema name: Conformance
            class Conformance < Base
              # Score - The conformance of the claim between and inclusive of 0 and 1, where 1 is 100% conformance.
              prop :score, :float, minimum: 0, maximum: 1
              # Rationale - The rationale for the conformance score.
              prop :rationale, :string
              # Mitigation Strategies - The list of  `bom-ref` to the evidence provided describing the mitigation strategies.
              prop :mitigation_strategies, :array, items: [:string, pattern: Pattern::REF_LINK]
            end

            # Requirement - The `bom-ref` to the requirement being attested to.
            prop :requirement, :string, pattern: Pattern::REF_LINK
            # Claims - The list of `bom-ref` to the claims being attested to.
            prop :claims, :array, items: [:string, pattern: Pattern::REF_LINK]
            # Counter Claims - The list of  `bom-ref` to the counter claims being attested to.
            prop :counter_claims, :array, items: [:string, pattern: Pattern::REF_LINK]
            # Conformance - The conformance of the claim meeting a requirement.
            prop :conformance, Conformance
            # Confidence - The confidence of the claim meeting the requirement.
            prop :confidence, Confidence
          end

          # Summary - The short description explaining the main points of the attestation.
          prop :summary, :string
          # Assessor - The `bom-ref` to the assessor asserting the attestation.
          prop :assessor, :string, pattern: Pattern::REF_LINK
          # Map - The grouping of requirements to claims and the attestors declared conformance and confidence thereof.
          prop :requirements_map, :array, items: Map, json_name: "map"
          # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
          prop :signature, :union, of: Signature::UNION_TYPE
        end

        # Schema name: Claim
        class Claim < Base
          # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
          prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
          # Target - The `bom-ref` to a target representing a specific system, application, API, module, team, person, process, business unit, company, etc...  that this claim is being applied to.
          prop :target, :string, pattern: Pattern::REF_LINK
          # Predicate - The specific statement or assertion about the target.
          prop :predicate, :string
          # Mitigation Strategies - The list of  `bom-ref` to the evidence provided describing the mitigation strategies. Each mitigation strategy should include an explanation of how any weaknesses in the evidence will be mitigated.
          prop :mitigation_strategies, :array, items: [:string, pattern: Pattern::REF_LINK]
          # Reasoning - The written explanation of why the evidence provided substantiates the claim.
          prop :reasoning, :string
          # Evidence - The list of `bom-ref` to evidence that supports this claim.
          prop :evidence, :array, items: [:string, pattern: Pattern::REF_LINK]
          # Counter Evidence - The list of `bom-ref` to counterEvidence that supports this claim.
          prop :counter_evidence, :array, items: [:string, pattern: Pattern::REF_LINK]
          # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
          prop :external_references, :array, items: ExternalReference
          # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
          prop :signature, :union, of: Signature::UNION_TYPE
        end

        # Schema name: Evidence
        class Evidence < Base
          # Schema name: EvidenceData
          class EvidenceData < Base
            # Schema name: Contents
            class Contents < Base
              # Data Attachment - An optional way to include textual or encoded data.
              prop :attachment, Attachment
              # Data URL - The URL to where the data can be retrieved.
              prop :url, :uri
            end

            # Data Name - The name of the data.
            prop :name, :string
            # Data Contents - The contents or references to the contents of the data being described.
            prop :contents, Contents
            # Data Classification - Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.
            prop :classification, :string
            # Sensitive Data - A description of any sensitive data included.
            prop :sensitive_data, :array, items: :string
            # Data Governance - Data governance information.
            prop :governance, DataGovernance
          end

          # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
          prop :bom_ref, :string, pattern: Pattern::REF_LINK, json_name: "bom-ref"
          # Property Name - The reference to the property name as defined in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy/).
          prop :property_name, :string
          # Description - The written description of what this evidence is and how it was created.
          prop :description, :string
          # Data - The output or analysis that supports claims.
          prop :data, :array, items: EvidenceData
          # Created - The date and time (timestamp) when the evidence was created.
          prop :created, :date_time
          # Expires - The optional date and time (timestamp) when the evidence is no longer valid.
          prop :expires, :date_time
          # Author - The author of the evidence.
          prop :author, OrganizationalContact
          # Reviewer - The reviewer of the evidence.
          prop :reviewer, OrganizationalContact
          # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
          prop :signature, :union, of: Signature::UNION_TYPE
        end

        # Schema name: Target
        class Target < Base
          # Organizations - The list of organizations which claims are made against.
          prop :organizations, :array, items: OrganizationalEntity
          # Components - The list of components which claims are made against.
          prop :components, :array, items: Component
          # Services - The list of services which claims are made against.
          prop :services, :array, items: Service
        end

        # Assessors - The list of assessors evaluating claims and determining conformance to requirements and confidence in that assessment.
        prop :assessors, :array, items: Assessor
        # Attestations - The list of attestations asserted by an assessor that maps requirements to claims.
        prop :attestations, :array, items: Attestation
        # Claims - The list of claims.
        prop :claims, :array, items: Claim
        # Evidence - The list of evidence
        prop :evidence, :array, items: Evidence
        # Targets - The list of targets which claims are made against.
        prop :targets, :array, items: Target
        # Affirmation - A concise statement affirmed by an individual regarding all declarations, often used for third-party auditor acceptance or recipient acknowledgment. It includes a list of authorized signatories who assert the validity of the document on behalf of the organization.
        prop :affirmation, Affirmation
        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html)
        prop :signature, :union, of: Signature::UNION_TYPE
      end
    end
  end
end
