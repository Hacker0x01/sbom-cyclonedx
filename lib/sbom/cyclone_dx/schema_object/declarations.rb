# frozen_string_literal: true
# rbs_inline: enabled

# Declarations - The list of declarations which describe the conformance to standards. Each declaration may include attestations, claims, and evidence.
module SBOM
  module CycloneDX
    Declarations = SchemaObject.build("Declarations") do
      # Assessors - The list of assessors evaluating claims and determining conformance to requirements and confidence in that assessment.
      prop :assessors, [Assessor]

      # Attestations - The list of attestations asserted by an assessor that maps requirements to claims.
      prop :attestations, [Attestation]

      # Claims - The list of claims.
      prop :claims, [Claim]

      # Evidence - The list of evidence
      prop :evidence, [Evidence]

      # Targets - The list of targets which claims are made against.
      prop :targets, [Target]

      # Affirmation - A concise statement affirmed by an individual regarding all declarations, often used for third-party auditor acceptance or recipient acknowledgment. It includes a list of authorized signatories who assert the validity of the document on behalf of the organization.
      prop :affirmation, Affirmation

      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html)
      prop :signature, Signature

      Affirmation = SchemaObject.build("Affirmation") do
        # Statement - The brief statement affirmed by an individual regarding all declarations.\n*- Notes This could be an affirmation of acceptance by a third-party auditor or receiving individual of a file.
        # Example: "I certify, to the best of my knowledge, that all information is correct."
        prop :statement, String

        # Signatories - The list of signatories authorized on behalf of an organization to assert validity of this document.
        prop :signatories, [Signatory]

        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        prop :signature, Signature

        Signatory = SchemaObject.build("Signatory") do
          # Name - The signatory's name.
          prop :name, String

          # Role - The signatory's role within an organization.
          prop :role, String

          # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
          prop :signature, Signature, required: -> { external_reference.nil? || organization.nil? }

          # Organization - The signatory's organization.
          prop :organization, OrganizationalEntity, required: -> { signature.nil? }

          # External Reference - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
          prop :external_reference, ExternalReference, required: -> { signature.nil? }
        end
      end

      Assessor = SchemaObject.build("Assessor") do
        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
        prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK

        # Third Party - The boolean indicating if the assessor is outside the organization generating claims. A value of false indicates a self assessor.
        prop :third_party, :bool

        # Organization - The entity issuing the assessment.
        prop :organization, OrganizationalEntity
      end

      Attestation = SchemaObject.build("Attestation") do
        # Summary - The short description explaining the main points of the attestation.
        prop :summary, String

        # Assessor - The `bom-ref` to the assessor asserting the attestation.
        prop :assessor, String, pattern: Pattern::REF_LINK

        # Map - The grouping of requirements to claims and the attestors declared conformance and confidence thereof.
        prop :map, [Map]

        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        prop :signature, Signature

        Map = SchemaObject.build("Map") do
          # Requirement - The `bom-ref` to the requirement being attested to.
          prop :requirement, String, pattern: Pattern::REF_LINK

          # Claims - The list of `bom-ref` to the claims being attested to.
          prop :claims, [String], all: { pattern: Pattern::REF_LINK }

          # Counter Claims - The list of  `bom-ref` to the counter claims being attested to.
          prop :counter_claims, [String], all: { pattern: Pattern::REF_LINK }

          # Conformance - The conformance of the claim meeting a requirement.
          prop :conformance, Conformance

          # Confidence - The confidence of the claim meeting the requirement.
          prop :confidence, Confidence

          Conformance = SchemaObject.build("Conformance") do
            # Score - The conformance of the claim between and inclusive of 0 and 1, where 1 is 100% conformance.
            prop :score, Float, minimum: 0, maximum: 1

            # Rationale - The rationale for the conformance score.
            prop :rationale, String

            # Mitigation Strategies - The list of  `bom-ref` to the evidence provided describing the mitigation strategies.
            prop :mitigation_strategies, [String], all: { pattern: Pattern::REF_LINK }
          end

          Confidence = SchemaObject.build("Confidence") do
            # Score - The confidence of the claim between and inclusive of 0 and 1, where 1 is 100% confidence.
            prop :score, Float, minimum: 0, maximum: 1

            # Rationale - The rationale for the confidence score.
            prop :rationale, String
          end
        end
      end

      Claim = SchemaObject.build("Claim") do
        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
        prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK

        # Target - The `bom-ref` to a target representing a specific system, application, API, module, team, person, process, business unit, company, etc...  that this claim is being applied to.
        prop :target, String, pattern: Pattern::REF_LINK

        # Predicate - The specific statement or assertion about the target.
        prop :predicate, String

        # Mitigation Strategies - The list of  `bom-ref` to the evidence provided describing the mitigation strategies. Each mitigation strategy should include an explanation of how any weaknesses in the evidence will be mitigated.
        prop :mitigation_strategies, [String], all: { pattern: Pattern::REF_LINK }

        # Reasoning - The written explanation of why the evidence provided substantiates the claim.
        prop :reasoning, String

        # Evidence - The list of `bom-ref` to evidence that supports this claim.
        prop :evidence, [String], all: { pattern: Pattern::REF_LINK }

        # Counter Evidence - The list of `bom-ref` to counterEvidence that supports this claim.
        prop :counter_evidence, [String], all: { pattern: Pattern::REF_LINK }

        # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
        prop :external_references, [ExternalReference]

        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        prop :signature, Signature
      end

      Evidence = SchemaObject.build("Evidence") do
        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
        prop :bom_ref, String, json_alias: "bom-ref", pattern: Pattern::REF_LINK

        # Property Name - The reference to the property name as defined in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy/).
        prop :property_name, String

        # Description - The written description of what this evidence is and how it was created.
        prop :description, String

        # Data - The output or analysis that supports claims.
        prop :data, [EvidenceData]

        # Created - The date and time (timestamp) when the evidence was created.
        prop :created, DateTime

        # Expires - The optional date and time (timestamp) when the evidence is no longer valid.
        prop :expires, DateTime

        # Author - The author of the evidence.
        prop :author, OrganizationalContact

        # Reviewer - The reviewer of the evidence.
        prop :reviewer, OrganizationalContact

        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        prop :signature, Signature

        EvidenceData = SchemaObject.build("EvidenceData") do
          # Data Name - The name of the data.
          prop :name, String

          # Data Contents - The contents or references to the contents of the data being described.
          prop :contents, Contents

          # Data Classification - Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.
          prop :classification, String

          # Sensitive Data - A description of any sensitive data included.
          prop :sensitive_data, [String]

          # Data Governance - Data governance information.
          prop :governance, DataGovernance

          Contents = SchemaObject.build("Contents") do
            # Data Attachment - An optional way to include textual or encoded data.
            prop :attachment, Attachment

            # Data URL - The URL to where the data can be retrieved.
            prop :url, URI
          end
        end
      end

      Target = SchemaObject.build("Target") do
        # Organizations - The list of organizations which claims are made against.
        prop :organizations, [OrganizationalEntity]

        # Components - The list of components which claims are made against.
        prop :components, [Component]

        # Services - The list of services which claims are made against.
        prop :services, [Service]
      end
    end
  end
end
