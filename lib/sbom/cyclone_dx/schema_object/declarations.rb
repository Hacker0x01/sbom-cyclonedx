# frozen_string_literal: true

require_relative "../enum"
require_relative "../pattern"
require_relative "../schema_object"

# Declarations - The list of declarations which describe the conformance to standards. Each declaration may include attestations, claims, and evidence.
module SBOM
  module CycloneDX
    class Declarations < Struct.new(
      "Declarations",
      # Assessors - The list of assessors evaluating claims and determining conformance to requirements and confidence in that assessment.
      :assessors,
      # Attestations - The list of attestations asserted by an assessor that maps requirements to claims.
      :attestations,
      # Claims - The list of claims.
      :claims,
      # Evidence - The list of evidence
      :evidence,
      # Targets - The list of targets which claims are made against.
      :targets,
      # Affirmation - A concise statement affirmed by an individual regarding all declarations, often used for third-party auditor acceptance or recipient acknowledgment. It includes a list of authorized signatories who assert the validity of the document on behalf of the organization.
      :affirmation,
      # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html)
      :signature,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(Array, assessors, items: Assessor) &&
          Validator.valid?(Array, attestations, items: Attestation) &&
          Validator.valid?(Array, claims, items: Claim) &&
          Validator.valid?(Array, evidence, items: Evidence) &&
          Validator.valid?(Array, targets, items: Target) &&
          Validator.valid?(Affirmation, affirmation) &&
          Signature.valid?(signature)
      end

      class Affirmation < Struct.new(
        "Affirmation",
        # Statement - The brief statement affirmed by an individual regarding all declarations.\n*- Notes This could be an affirmation of acceptance by a third-party auditor or receiving individual of a file.
        # Example: "I certify, to the best of my knowledge, that all information is correct."
        :statement,
        # Signatories - The list of signatories authorized on behalf of an organization to assert validity of this document.
        :signatories,
        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        :signature,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(String, statement) &&
            Validator.valid?(Array, signatories, items: Signatory) &&
            Signature.valid?(signature)
        end

        class Signatory < Struct.new(
          "Signatory",
          # Name - The signatory's name.
          :name,
          # Role - The signatory's role within an organization.
          :role,
          # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
          :signature,
          # Organization - The signatory's organization.
          :organization,
          # External Reference - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
          :external_reference,
          keyword_init: true
        )
          include SchemaObject

          def initialize(name: nil, role: nil, signature: nil, organization: nil, external_reference: nil)
            if signature.nil? && (organization.nil? || external_reference.nil?)
              raise ArgumentError, "must specify organization and external_reference if signature is not provided"
            end

            super
          end

          def valid?
            Validator.valid?(String, name) &&
              Validator.valid?(String, role) &&
              Signature.valid?(signature, required: organization.nil? || external_reference.nil?) &&
              Validator.valid?(OrganizationalEntity, organization, required: signature.nil?) &&
              Validator.valid?(ExternalReference, external_reference, required: signature.nil?)
          end
        end
      end

      class Assessor < Struct.new(
        "Assessor",
        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
        :bom_ref,
        # Third Party - The boolean indicating if the assessor is outside the organization generating claims. A value of false indicates a self assessor.
        :third_party,
        # Organization - The entity issuing the assessment.
        :organization,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
            Validator.valid?(Boolean, third_party) &&
            Validator.valid?(OrganizationalEntity, organization)
        end
      end

      class Attestation < Struct.new(
        "Attestation",
        # Summary - The short description explaining the main points of the attestation.
        :summary,
        # Assessor - The `bom-ref` to the assessor asserting the attestation.
        :assessor,
        # Map - The grouping of requirements to claims and the attestors declared conformance and confidence thereof.
        :requirements_map,
        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        :signature,
        keyword_init: true
      )
        include SchemaObject

        json_name :requirements_map, "map"

        def valid?
          Validator.valid?(String, summary) &&
            Validator.valid?(String, assessor, pattern: Pattern::REF_LINK) &&
            Validator.valid?(Array, requirements_map, items: Map) &&
            Signature.valid?(signature)
        end

        class Map < Struct.new(
          "Map",
          # Requirement - The `bom-ref` to the requirement being attested to.
          :requirement,
          # Claims - The list of `bom-ref` to the claims being attested to.
          :claims,
          # Counter Claims - The list of  `bom-ref` to the counter claims being attested to.
          :counter_claims,
          # Conformance - The conformance of the claim meeting a requirement.
          :conformance,
          # Confidence - The confidence of the claim meeting the requirement.
          :confidence,
          keyword_init: true
        )
          include SchemaObject

          def valid?
            Validator.valid?(String, requirement, pattern: Pattern::REF_LINK) &&
              Validator.valid?(Array, claims, items: [String, pattern: Pattern::REF_LINK]) &&
              Validator.valid?(Array, counter_claims, items: [String, pattern: Pattern::REF_LINK]) &&
              Validator.valid?(Conformance, conformance) &&
              Validator.valid?(Confidence, confidence)
          end

          class Conformance < Struct.new(
            "Conformance",
            # Score - The conformance of the claim between and inclusive of 0 and 1, where 1 is 100% conformance.
            :score,
            # Rationale - The rationale for the conformance score.
            :rationale,
            # Mitigation Strategies - The list of  `bom-ref` to the evidence provided describing the mitigation strategies.
            :mitigation_strategies,
            keyword_init: true
          )
            include SchemaObject

            def valid?
              Validator.valid?(Float, score, minimum: 0, maximum: 1) &&
                Validator.valid?(String, rationale) &&
                Validator.valid?(
                  Array,
                  mitigation_strategies,
                  items: [String, pattern: Pattern::REF_LINK]
                )
            end
          end

          class Confidence < Struct.new(
            "Confidence",
            # Score - The confidence of the claim between and inclusive of 0 and 1, where 1 is 100% confidence.
            :score,
            # Rationale - The rationale for the confidence score.
            :rationale,
            keyword_init: true
          )
            include SchemaObject

            def valid?
              Validator.valid?(Float, score, minimum: 0, maximum: 1) &&
                Validator.valid?(String, rationale)
            end
          end
        end
      end

      class Claim < Struct.new(
        "Claim",
        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
        :bom_ref,
        # Target - The `bom-ref` to a target representing a specific system, application, API, module, team, person, process, business unit, company, etc...  that this claim is being applied to.
        :target,
        # Predicate - The specific statement or assertion about the target.
        :predicate,
        # Mitigation Strategies - The list of  `bom-ref` to the evidence provided describing the mitigation strategies. Each mitigation strategy should include an explanation of how any weaknesses in the evidence will be mitigated.
        :mitigation_strategies,
        # Reasoning - The written explanation of why the evidence provided substantiates the claim.
        :reasoning,
        # Evidence - The list of `bom-ref` to evidence that supports this claim.
        :evidence,
        # Counter Evidence - The list of `bom-ref` to counterEvidence that supports this claim.
        :counter_evidence,
        # External References - External references provide a way to document systems, sites, and information that may be relevant but are not included with the BOM. They may also establish specific relationships within or external to the BOM.
        :external_references,
        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        :signature,
        keyword_init: true
      )
        include SchemaObject

        json_name :bom_ref, "bom-ref"

        def valid?
          Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
            Validator.valid?(String, target, pattern: Pattern::REF_LINK) &&
            Validator.valid?(String, predicate) &&
            Validator.valid?(Array, mitigation_strategies, items: [String, pattern: Pattern::REF_LINK]) &&
            Validator.valid?(String, reasoning) &&
            Validator.valid?(Array, evidence, items: [String, pattern: Pattern::REF_LINK]) &&
            Validator.valid?(Array, counter_evidence, items: [String, pattern: Pattern::REF_LINK]) &&
            Validator.valid?(Array, external_references, items: ExternalReference) &&
            Signature.valid?(signature)
        end
      end

      class Evidence < Struct.new(
        "Evidence",
        # BOM Reference - An optional identifier which can be used to reference the object elsewhere in the BOM. Every bom-ref must be unique within the BOM.
        :bom_ref,
        # Property Name - The reference to the property name as defined in the [CycloneDX Property Taxonomy](https://github.com/CycloneDX/cyclonedx-property-taxonomy/).
        :property_name,
        # Description - The written description of what this evidence is and how it was created.
        :description,
        # Data - The output or analysis that supports claims.
        :data,
        # Created - The date and time (timestamp) when the evidence was created.
        :created,
        # Expires - The optional date and time (timestamp) when the evidence is no longer valid.
        :expires,
        # Author - The author of the evidence.
        :author,
        # Reviewer - The reviewer of the evidence.
        :reviewer,
        # Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
        :signature,
        keyword_init: true
      )
        include SchemaObject

        json_name :bom_ref, "bom-ref"

        def valid?
          Validator.valid?(String, bom_ref, pattern: Pattern::REF_LINK) &&
            Validator.valid?(String, property_name) &&
            Validator.valid?(String, description) &&
            Validator.valid?(Array, data, items: EvidenceData) &&
            Validator.valid?(DateTime, created) &&
            Validator.valid?(DateTime, expires) &&
            Validator.valid?(OrganizationalContact, author) &&
            Validator.valid?(OrganizationalContact, reviewer) &&
            Signature.valid?(signature)
        end

        class EvidenceData < Struct.new(
          "EvidenceData",
          # Data Name - The name of the data.
          :name,
          # Data Contents - The contents or references to the contents of the data being described.
          :contents,
          # Data Classification - Data classification tags data according to its type, sensitivity, and value if altered, stolen, or destroyed.
          :classification,
          # Sensitive Data - A description of any sensitive data included.
          :sensitive_data,
          # Data Governance - Data governance information.
          :governance,
          keyword_init: true
        )
          include SchemaObject

          def valid?
            Validator.valid?(String, name) &&
              Validator.valid?(Contents, contents) &&
              Validator.valid?(String, classification) &&
              Validator.valid?(Array, sensitive_data, items: String) &&
              Validator.valid?(DataGovernance, governance)
          end

          class Contents < Struct.new(
            "Contents",
            # Data Attachment - An optional way to include textual or encoded data.
            :attachment,
            # Data URL - The URL to where the data can be retrieved.
            :url,
            keyword_init: true
          )
            include SchemaObject

            def valid?
              Validator.valid?(Attachment, attachment) &&
                Validator.valid?(URI, url)
            end
          end
        end
      end

      class Target < Struct.new(
        "Target",
        # Organizations - The list of organizations which claims are made against.
        :organizations,
        # Components - The list of components which claims are made against.
        :components,
        # Services - The list of services which claims are made against.
        :services,
        keyword_init: true
      )
        include SchemaObject

        def valid?
          Validator.valid?(Array, organizations, items: OrganizationalEntity) &&
            Validator.valid?(Array, components, items: Component) &&
            Validator.valid?(Array, services, items: Service)
        end
      end
    end
  end
end
