# frozen_string_literal: true

module SBOM
  module CycloneDX
    module Enum # rubocop:disable Metrics/ModuleLength
      # Access mode - Describes the read-write access control for the workspace relative to the owning resource instance.
      ACCESS_MODE = %w[
        read-only
        read-write
        read-write-once
        write-once
        write-only
      ].freeze

      # Activity - The type of activity that is part of a machine learning model development or operational lifecycle.
      ACTIVITY = [
        # A model design including problem framing, goal definition and algorithm selection.
        "design",
        # Model data acquisition including search, selection and transfer.
        "data-collection",
        # Model data preparation including data cleaning, labeling and conversion.
        "data-preparation",
        # Model building, training and generalized tuning.
        "training",
        # Refining a trained model to produce desired outputs for a given problem space.
        "fine-tuning",
        # Model validation including model output evaluation and testing.
        "validation",
        # Explicit model deployment to a target hosting infrastructure.
        "deployment",
        # Generating an output response from a hosted model from a set of inputs.
        "inference",
        # A lifecycle activity type whose description does not match currently defined values.
        "other"
      ].freeze

      # The vulnerability status of a given version or range of versions of a product. The statuses 'affected' and 'unaffected' indicate that the version is affected or unaffected by the vulnerability. The status 'unknown' indicates that it is unknown or unspecified whether the given version is affected. There can be many reasons for an 'unknown' status, including that an investigation has not been undertaken or that a vendor has not disclosed the status.
      AFFECTED_STATUS = [
        # The version is affected by the vulnerability.
        "affected",
        # The version is not affected by the vulnerability.
        "unaffected",
        # It is unknown (or unspecified) whether the given version is affected.
        "unknown"
      ].freeze

      # Anonymous class from AggregateType
      AGGREGATE_TYPE = [
        # The relationship is complete. No further relationships including constituent components, services, or dependencies are known to exist.
        "complete",
        # The relationship is incomplete. Additional relationships exist and may include constituent components, services, or dependencies.
        "incomplete",
        # The relationship is incomplete. Only relationships for first-party components, services, or their dependencies are represented.
        "incomplete_first_party_only",
        # The relationship is incomplete. Only relationships for first-party components, services, or their dependencies are represented, limited specifically to those that are proprietary.
        "incomplete_first_party_proprietary_only",
        # The relationship is incomplete. Only relationships for first-party components, services, or their dependencies are represented, limited specifically to those that are opensource.
        "incomplete_first_party_opensource_only",
        # The relationship is incomplete. Only relationships for third-party components, services, or their dependencies are represented.
        "incomplete_third_party_only",
        # The relationship is incomplete. Only relationships for third-party components, services, or their dependencies are represented, limited specifically to those that are proprietary.
        "incomplete_third_party_proprietary_only",
        # The relationship is incomplete. Only relationships for third-party components, services, or their dependencies are represented, limited specifically to those that are opensource.
        "incomplete_third_party_opensource_only",
        # The relationship may be complete or incomplete. This usually signifies a 'best-effort' to obtain constituent components, services, or dependencies but the completeness is inconclusive.
        "unknown",
        # The relationship completeness is not specified.
        "not_specified"
      ].freeze

      # Asset Type - Cryptographic assets occur in several forms. Algorithms and protocols are most commonly implemented in specialized cryptographic libraries. They may, however, also be 'hardcoded' in software components. Certificates and related cryptographic material like keys, tokens, secrets or passwords are other cryptographic assets to be modelled.
      ASSET_TYPE = [
        # Mathematical function commonly used for data encryption, authentication, and digital signatures.
        "algorithm",
        # An electronic document that is used to provide the identity or validate a public key.
        "certificate",
        # A set of rules and guidelines that govern the behavior and communication with each other.
        "protocol",
        # Other cryptographic assets related to algorithms, certificates, and protocols such as keys and tokens.
        "related-crypto-material"
      ].freeze

      # Certification Level
      CERTIFICATION_LEVEL = [
        # No certification obtained
        "none",
        # FIPS 140-1 Level 1
        "fips140-1-l1",
        # FIPS 140-1 Level 2
        "fips140-1-l2",
        # FIPS 140-1 Level 3
        "fips140-1-l3",
        # FIPS 140-1 Level 4
        "fips140-1-l4",
        # FIPS 140-2 Level 1
        "fips140-2-l1",
        # FIPS 140-2 Level 2
        "fips140-2-l2",
        # FIPS 140-2 Level 3
        "fips140-2-l3",
        # FIPS 140-2 Level 4
        "fips140-2-l4",
        # FIPS 140-3 Level 1
        "fips140-3-l1",
        # FIPS 140-3 Level 2
        "fips140-3-l2",
        # FIPS 140-3 Level 3
        "fips140-3-l3",
        # FIPS 140-3 Level 4
        "fips140-3-l4",
        # Common Criteria - Evaluation Assurance Level 1
        "cc-eal1",
        # Common Criteria - Evaluation Assurance Level 1 (Augmented)
        "cc-eal1+",
        # Common Criteria - Evaluation Assurance Level 2
        "cc-eal2",
        # Common Criteria - Evaluation Assurance Level 2 (Augmented)
        "cc-eal2+",
        # Common Criteria - Evaluation Assurance Level 3
        "cc-eal3",
        # Common Criteria - Evaluation Assurance Level 3 (Augmented)
        "cc-eal3+",
        # Common Criteria - Evaluation Assurance Level 4
        "cc-eal4",
        # Common Criteria - Evaluation Assurance Level 4 (Augmented)
        "cc-eal4+",
        # Common Criteria - Evaluation Assurance Level 5
        "cc-eal5",
        # Common Criteria - Evaluation Assurance Level 5 (Augmented)
        "cc-eal5+",
        # Common Criteria - Evaluation Assurance Level 6
        "cc-eal6",
        # Common Criteria - Evaluation Assurance Level 6 (Augmented)
        "cc-eal6+",
        # Common Criteria - Evaluation Assurance Level 7
        "cc-eal7",
        # Common Criteria - Evaluation Assurance Level 7 (Augmented)
        "cc-eal7+",
        # Another certification
        "other",
        # The certification level is not known
        "unknown"
      ].freeze

      # Component Type - Specifies the type of component. For software components, classify as application if no more specific appropriate classification is available or cannot be determined for the component.
      COMPONENT_TYPE = [
        # A software application. Refer to [https://en.wikipedia.org/wiki/Application_software](https://en.wikipedia.org/wiki/Application_software) for information about applications.
        "application",
        # A software framework. Refer to [https://en.wikipedia.org/wiki/Software_framework](https://en.wikipedia.org/wiki/Software_framework) for information on how frameworks vary slightly from libraries.
        "framework",
        # A software library. Refer to [https://en.wikipedia.org/wiki/Library_(computing)](https://en.wikipedia.org/wiki/Library_(computing)) for information about libraries. All third-party and open source reusable components will likely be a library. If the library also has key features of a framework, then it should be classified as a framework. If not, or is unknown, then specifying library is recommended.
        "library",
        # A packaging and/or runtime format, not specific to any particular technology, which isolates software inside the container from software outside of a container through virtualization technology. Refer to [https://en.wikipedia.org/wiki/OS-level_virtualization](https://en.wikipedia.org/wiki/OS-level_virtualization).
        "container",
        # A runtime environment which interprets or executes software. This may include runtimes such as those that execute bytecode or low-code/no-code application platforms.
        "platform",
        # A software operating system without regard to deployment model (i.e. installed on physical hardware, virtual machine, image, etc) Refer to [https://en.wikipedia.org/wiki/Operating_system](https://en.wikipedia.org/wiki/Operating_system).
        "operating-system",
        # A hardware device such as a processor or chip-set. A hardware device containing firmware SHOULD include a component for the physical hardware itself and another component of type 'firmware' or 'operating-system' (whichever is relevant), describing information about the software running on the device. See also the list of [known device properties](https://github.com/CycloneDX/cyclonedx-property-taxonomy/blob/main/cdx/device.md).
        "device",
        # A special type of software that operates or controls a particular type of device. Refer to [https://en.wikipedia.org/wiki/Device_driver](https://en.wikipedia.org/wiki/Device_driver).
        "device-driver",
        # A special type of software that provides low-level control over a device's hardware. Refer to [https://en.wikipedia.org/wiki/Firmware](https://en.wikipedia.org/wiki/Firmware).
        "firmware",
        # A computer file. Refer to [https://en.wikipedia.org/wiki/Computer_file](https://en.wikipedia.org/wiki/Computer_file) for information about files.
        "file",
        # A model based on training data that can make predictions or decisions without being explicitly programmed to do so.
        "machine-learning-model",
        # A collection of discrete values that convey information.
        "data",
        # A cryptographic asset including algorithms, protocols, certificates, keys, tokens, and secrets.
        "cryptographic-asset"
      ].freeze

      # Cryptographic function
      CRYPTO_FUNCTION = %w[
        generate
        keygen
        encrypt
        decrypt
        digest
        tag
        keyderive
        sign
        verify
        encapsulate
        decapsulate
        other
        unknown
      ].freeze

      # Data flow direction - Specifies the flow direction of the data. Direction is relative to the service.
      DATA_FLOW_DIRECTION = [
        # Data that enters a service.
        "inbound",
        # Data that exits a service.
        "outbound",
        # Data flows in and out of the service.
        "bi-directional",
        # The directional flow of data is not known.
        "unknown"
      ].freeze

      COMPONENT_DATA_TYPE = [
        # Any type of code, code snippet, or data-as-code.
        "source-code",
        # Parameters or settings that may be used by other components.
        "configuration",
        # A collection of data.
        "dataset",
        # Data that can be used to create new instances of what the definition defines.
        "definition",
        # Any other type of data that does not fit into existing definitions.
        "other"
      ].freeze

      # Energy Source - The energy source for the energy provider.
      ENERGY_SOURCE = [
        # Energy produced by types of coal.
        "coal",
        # Petroleum products (primarily crude oil and its derivative fuel oils).
        "oil",
        # Hydrocarbon gas liquids (HGL) that occur as gases at atmospheric pressure and as liquids under higher pressures including Natural gas (C5H12 and heavier), Ethane (C2H6), Propane (C3H8), etc.
        "natural-gas",
        # Energy produced from the cores of atoms (i.e., through nuclear fission or fusion).
        "nuclear",
        # Energy produced from moving air.
        "wind",
        # Energy produced from the sun (i.e., solar radiation).
        "solar",
        # Energy produced from heat within the earth.
        "geothermal",
        # Energy produced from flowing water.
        "hydropower",
        # Liquid fuels produced from biomass feedstocks (i.e., organic materials such as plants or animals).
        "biofuel",
        # The energy source is unknown.
        "unknown",
        # An energy source that is not listed.
        "other"
      ].freeze

      # Execution Environment - The target and execution environment in which the algorithm is implemented in.
      EXECUTION_ENVIRONMENT = [
        # A software implementation running in plain unencrypted RAM.
        "software-plain-ram",
        # A software implementation running in encrypted RAM.
        "software-encrypted-ram",
        # A software implementation running in a trusted execution environment.
        "software-tee",
        # A hardware implementation.
        "hardware",
        # Another implementation environment.
        "other",
        # The execution environment is not known.
        "unknown"
      ].freeze

      EXTERNAL_REFERENCE_TYPE = [
        # Version Control System
        "vcs",
        # Issue or defect tracking system, or an Application Lifecycle Management (ALM) system
        "issue-tracker",
        # Website
        "website",
        # Security advisories
        "advisories",
        # Bill of Materials (SBOM, OBOM, HBOM, SaaSBOM, etc)
        "bom",
        # Mailing list or discussion group
        "mailing-list",
        # Social media account
        "social",
        # Real-time chat platform
        "chat",
        # Documentation, guides, or how-to instructions
        "documentation",
        # Community or commercial support
        "support",
        # The location where the source code distributable can be obtained. This is often an archive format such as zip or tgz. The source-distribution type complements use of the version control (vcs) type.
        "source-distribution",
        # Direct or repository download location
        "distribution",
        # The location where a component was published to. This is often the same as \"distribution\" but may also include specialized publishing processes that act as an intermediary.
        "distribution-intake",
        # The reference to the license file. If a license URL has been defined in the license node, it should also be defined as an external reference for completeness.
        "license",
        # Build-system specific meta file (i.e. pom.xml, package.json, .nuspec, etc)
        "build-meta",
        # Reference to an automated build system
        "build-system",
        # Reference to release notes
        "release-notes",
        # Specifies a way to contact the maintainer, supplier, or provider in the event of a security incident. Common URIs include links to a disclosure procedure, a mailto (RFC-2368) that specifies an email address, a tel (RFC-3966) that specifies a phone number, or dns (RFC-4501) that specifies the records containing DNS Security TXT.
        "security-contact",
        # A model card describes the intended uses of a machine learning model, potential limitations, biases, ethical considerations, training parameters, datasets used to train the model, performance metrics, and other relevant data useful for ML transparency.
        "model-card",
        # A record of events that occurred in a computer system or application, such as problems, errors, or information on current operations.
        "log",
        # Parameters or settings that may be used by other components or services.
        "configuration",
        # Information used to substantiate a claim.
        "evidence",
        # Describes how a component or service was manufactured or deployed.
        "formulation",
        # Human or machine-readable statements containing facts, evidence, or testimony.
        "attestation",
        # An enumeration of identified weaknesses, threats, and countermeasures, dataflow diagram (DFD), attack tree, and other supporting documentation in human-readable or machine-readable format.
        "threat-model",
        # The defined assumptions, goals, and capabilities of an adversary.
        "adversary-model",
        # Identifies and analyzes the potential of future events that may negatively impact individuals, assets, and/or the environment. Risk assessments may also include judgments on the tolerability of each risk.
        "risk-assessment",
        # A Vulnerability Disclosure Report (VDR) which asserts the known and previously unknown vulnerabilities that affect a component, service, or product including the analysis and findings describing the impact (or lack of impact) that the reported vulnerability has on a component, service, or product.
        "vulnerability-assertion",
        # A Vulnerability Exploitability eXchange (VEX) which asserts the known vulnerabilities that do not affect a product, product family, or organization, and optionally the ones that do. The VEX should include the analysis and findings describing the impact (or lack of impact) that the reported vulnerability has on the product, product family, or organization.
        "exploitability-statement",
        # Results from an authorized simulated cyberattack on a component or service, otherwise known as a penetration test.
        "pentest-report",
        # SARIF or proprietary machine or human-readable report for which static analysis has identified code quality, security, and other potential issues with the source code.
        "static-analysis-report",
        # Dynamic analysis report that has identified issues such as vulnerabilities and misconfigurations.
        "dynamic-analysis-report",
        # Report generated by analyzing the call stack of a running application.
        "runtime-analysis-report",
        # Report generated by Software Composition Analysis (SCA), container analysis, or other forms of component analysis.
        "component-analysis-report",
        # Report containing a formal assessment of an organization, business unit, or team against a maturity model.
        "maturity-report",
        # Industry, regulatory, or other certification from an accredited (if applicable) certification body.
        "certification-report",
        # Code or configuration that defines and provisions virtualized infrastructure, commonly referred to as Infrastructure as Code (IaC).
        "codified-infrastructure",
        # Report or system in which quality metrics can be obtained.
        "quality-metrics",
        # Plans of Action and Milestones (POA&M) complement an \"attestation\" external reference. POA&M is defined by NIST as a \"document that identifies tasks needing to be accomplished. It details resources required to accomplish the elements of the plan, any milestones in meeting the tasks and scheduled completion dates for the milestones\".
        "poam",
        # An e-signature is commonly a scanned representation of a written signature or a stylized script of the person's name.
        "electronic-signature",
        # A signature that leverages cryptography, typically public/private key pairs, which provides strong authenticity verification.
        "digital-signature",
        # Document that complies with [RFC 9116](https://www.ietf.org/rfc/rfc9116.html) (A File Format to Aid in Security Vulnerability Disclosure)
        "rfc-9116",
        # Use this if no other types accurately describe the purpose of the external reference.
        "other"
      ].freeze

      # Field - The identity field of the component which the evidence describes.
      FIELD = %w[
        group
        name
        version
        purl
        cpe
        omniborId
        swhid
        swid
        hash
      ].freeze

      # Hash Algorithm - The algorithm that generated the hash value.
      HASH_ALG = %w[
        MD5
        SHA-1
        SHA-256
        SHA-384
        SHA-512
        SHA3-256
        SHA3-384
        SHA3-512
        BLAKE2b-256
        BLAKE2b-384
        BLAKE2b-512
        BLAKE3
      ].freeze

      # Impact Analysis Justification - The rationale of why the impact analysis state was asserted.
      IMPACT_ANALYSIS_JUSTIFICATION = [
        # The code has been removed or tree-shaked.
        "code_not_present",
        # The vulnerable code is not invoked at runtime.
        "code_not_reachable",
        # Exploitability requires a configurable option to be set/unset.
        "requires_configuration",
        # Exploitability requires a dependency that is not present.
        "requires_dependency",
        # Exploitability requires a certain environment which is not present.
        "requires_environment",
        # Exploitability requires a compiler flag to be set/unset.
        "protected_by_compiler",
        # Exploits are prevented at runtime.
        "protected_at_runtime",
        # Attacks are blocked at physical, logical, or network perimeter.
        "protected_at_perimeter",
        # Preventative measures have been implemented that reduce the likelihood and/or impact of the vulnerability.
        "protected_by_mitigating_control"
      ].freeze

      # Impact Analysis State - Declares the current state of an occurrence of a vulnerability, after automated or manual analysis.
      IMPACT_ANALYSIS_STATE = [
        # The vulnerability has been remediated.
        "resolved",
        # The vulnerability has been remediated and evidence of the changes are provided in the affected components pedigree containing verifiable commit history and/or diff(s).
        "resolved_with_pedigree",
        # The vulnerability may be directly or indirectly exploitable.
        "exploitable",
        # The vulnerability is being investigated.
        "in_triage",
        # The vulnerability is not specific to the component or service and was falsely identified or associated.
        "false_positive",
        # The component or service is not affected by the vulnerability. Justification should be specified for all not_affected cases.
        "not_affected"
      ].freeze

      # Implementation platform - The target platform for which the algorithm is implemented. The implementation can be 'generic', running on any platform or for a specific platform.
      IMPLEMENTATION_PLATFORM = %w[
        generic
        x86_32
        x86_64
        armv7-a
        armv7-m
        armv8-a
        armv8-m
        armv9-a
        armv9-m
        s390x
        ppc64
        ppc64le
        other
        unknown
      ].freeze

      # Issue Type - Specifies the type of issue
      ISSUE_TYPE = [
        # A fault, flaw, or bug in software.
        "defect",
        # A new feature or behavior in software.
        "enhancement",
        # A special type of defect which impacts security.
        "security"
      ].freeze

      # Learning Type - Learning types describing the learning problem or hybrid learning problem.
      LEARNING_TYPE = [
        # Supervised machine learning involves training an algorithm on labeled data to predict or classify new data based on the patterns learned from the labeled examples.
        "supervised",
        # Unsupervised machine learning involves training algorithms on unlabeled data to discover patterns, structures, or relationships without explicit guidance, allowing the model to identify inherent structures or clusters within the data.
        "unsupervised",
        # Reinforcement learning is a type of machine learning where an agent learns to make decisions by interacting with an environment to maximize cumulative rewards, through trial and error.
        "reinforcement-learning",
        # Semi-supervised machine learning utilizes a combination of labeled and unlabeled data during training to improve model performance, leveraging the benefits of both supervised and unsupervised learning techniques.
        "semi-supervised",
        # Self-supervised machine learning involves training models to predict parts of the input data from other parts of the same data, without requiring external labels, enabling learning from large amounts of unlabeled data.
        "self-supervised"
      ].freeze

      # License ID (SPDX) - A valid SPDX license identifier. If specified, this value must be one of the enumeration of valid SPDX license identifiers defined in the spdx.schema.json (or spdx.xml) subschema which is synchronized with the official SPDX license list.
      LICENSE_ID = [
        # Attribution Assurance License
        "AAL",
        # Abstyles License
        "Abstyles",
        # AdaCore Doc License
        "AdaCore-doc",
        # Adobe Systems Incorporated Source Code License Agreement
        "Adobe-2006",
        # Adobe Display PostScript License
        "Adobe-Display-PostScript",
        # Adobe Glyph List License
        "Adobe-Glyph",
        # Adobe Utopia Font License
        "Adobe-Utopia",
        # Amazon Digital Services License
        "ADSL",
        # Academic Free License v1.1
        "AFL-1.1",
        # Academic Free License v1.2
        "AFL-1.2",
        # Academic Free License v2.0
        "AFL-2.0",
        # Academic Free License v2.1
        "AFL-2.1",
        # Academic Free License v3.0
        "AFL-3.0",
        # Afmparse License
        "Afmparse",
        # Affero General Public License v1.0
        "AGPL-1.0",
        # Affero General Public License v1.0 only
        "AGPL-1.0-only",
        # Affero General Public License v1.0 or later
        "AGPL-1.0-or-later",
        # GNU Affero General Public License v3.0
        "AGPL-3.0",
        # GNU Affero General Public License v3.0 only
        "AGPL-3.0-only",
        # GNU Affero General Public License v3.0 or later
        "AGPL-3.0-or-later",
        # Aladdin Free Public License
        "Aladdin",
        # AMD newlib License
        "AMD-newlib",
        # AMD's plpa_map.c License
        "AMDPLPA",
        # Apple MIT License
        "AML",
        # AML glslang variant License
        "AML-glslang",
        # Academy of Motion Picture Arts and Sciences BSD
        "AMPAS",
        # ANTLR Software Rights Notice
        "ANTLR-PD",
        # ANTLR Software Rights Notice with license fallback
        "ANTLR-PD-fallback",
        # Any OSI License
        "any-OSI",
        # Apache License 1.0
        "Apache-1.0",
        # Apache License 1.1
        "Apache-1.1",
        # Apache License 2.0
        "Apache-2.0",
        # Adobe Postscript AFM License
        "APAFML",
        # Adaptive Public License 1.0
        "APL-1.0",
        # App::s2p License
        "App-s2p",
        # Apple Public Source License 1.0
        "APSL-1.0",
        # Apple Public Source License 1.1
        "APSL-1.1",
        # Apple Public Source License 1.2
        "APSL-1.2",
        # Apple Public Source License 2.0
        "APSL-2.0",
        # Arphic Public License
        "Arphic-1999",
        # Artistic License 1.0
        "Artistic-1.0",
        # Artistic License 1.0 w/clause 8
        "Artistic-1.0-cl8",
        # Artistic License 1.0 (Perl)
        "Artistic-1.0-Perl",
        # Artistic License 2.0
        "Artistic-2.0",
        # ASWF Digital Assets License version 1.0
        "ASWF-Digital-Assets-1.0",
        # ASWF Digital Assets License 1.1
        "ASWF-Digital-Assets-1.1",
        # Baekmuk License
        "Baekmuk",
        # Bahyph License
        "Bahyph",
        # Barr License
        "Barr",
        # bcrypt Solar Designer License
        "bcrypt-Solar-Designer",
        # Beerware License
        "Beerware",
        # Bitstream Charter Font License
        "Bitstream-Charter",
        # Bitstream Vera Font License
        "Bitstream-Vera",
        # BitTorrent Open Source License v1.0
        "BitTorrent-1.0",
        # BitTorrent Open Source License v1.1
        "BitTorrent-1.1",
        # SQLite Blessing
        "blessing",
        # Blue Oak Model License 1.0.0
        "BlueOak-1.0.0",
        # Boehm-Demers-Weiser GC License
        "Boehm-GC",
        # Borceux license
        "Borceux",
        # Brian Gladman 2-Clause License
        "Brian-Gladman-2-Clause",
        # Brian Gladman 3-Clause License
        "Brian-Gladman-3-Clause",
        # BSD Zero Clause License
        "0BSD",
        # BSD 1-Clause License
        "BSD-1-Clause",
        # BSD 2-Clause "Simplified" License
        "BSD-2-Clause",
        # BSD 2-Clause - Ian Darwin variant
        "BSD-2-Clause-Darwin",
        # BSD 2-Clause - first lines requirement
        "BSD-2-Clause-first-lines",
        # BSD 2-Clause FreeBSD License
        "BSD-2-Clause-FreeBSD",
        # BSD 2-Clause NetBSD License
        "BSD-2-Clause-NetBSD",
        # BSD-2-Clause Plus Patent License
        "BSD-2-Clause-Patent",
        # BSD 2-Clause with views sentence
        "BSD-2-Clause-Views",
        # BSD 3-Clause "New" or "Revised" License
        "BSD-3-Clause",
        # BSD 3-Clause acpica variant
        "BSD-3-Clause-acpica",
        # BSD with attribution
        "BSD-3-Clause-Attribution",
        # BSD 3-Clause Clear License
        "BSD-3-Clause-Clear",
        # BSD 3-Clause Flex variant
        "BSD-3-Clause-flex",
        # Hewlett-Packard BSD variant license
        "BSD-3-Clause-HP",
        # Lawrence Berkeley National Labs BSD variant license
        "BSD-3-Clause-LBNL",
        # BSD 3-Clause Modification
        "BSD-3-Clause-Modification",
        # BSD 3-Clause No Military License
        "BSD-3-Clause-No-Military-License",
        # BSD 3-Clause No Nuclear License
        "BSD-3-Clause-No-Nuclear-License",
        # BSD 3-Clause No Nuclear License 2014
        "BSD-3-Clause-No-Nuclear-License-2014",
        # BSD 3-Clause No Nuclear Warranty
        "BSD-3-Clause-No-Nuclear-Warranty",
        # BSD 3-Clause Open MPI variant
        "BSD-3-Clause-Open-MPI",
        # BSD 3-Clause Sun Microsystems
        "BSD-3-Clause-Sun",
        # BSD 4-Clause "Original" or "Old" License
        "BSD-4-Clause",
        # BSD 4 Clause Shortened
        "BSD-4-Clause-Shortened",
        # BSD-4-Clause (University of California-Specific)
        "BSD-4-Clause-UC",
        # BSD 4.3 RENO License
        "BSD-4.3RENO",
        # BSD 4.3 TAHOE License
        "BSD-4.3TAHOE",
        # BSD Advertising Acknowledgement License
        "BSD-Advertising-Acknowledgement",
        # BSD with Attribution and HPND disclaimer
        "BSD-Attribution-HPND-disclaimer",
        # BSD-Inferno-Nettverk
        "BSD-Inferno-Nettverk",
        # BSD Protection License
        "BSD-Protection",
        # BSD Source Code Attribution - beginning of file variant
        "BSD-Source-beginning-file",
        # BSD Source Code Attribution
        "BSD-Source-Code",
        # Systemics BSD variant license
        "BSD-Systemics",
        # Systemics W3Works BSD variant license
        "BSD-Systemics-W3Works",
        # Boost Software License 1.0
        "BSL-1.0",
        # Business Source License 1.1
        "BUSL-1.1",
        # bzip2 and libbzip2 License v1.0.5
        "bzip2-1.0.5",
        # bzip2 and libbzip2 License v1.0.6
        "bzip2-1.0.6",
        # Computational Use of Data Agreement v1.0
        "C-UDA-1.0",
        # Cryptographic Autonomy License 1.0
        "CAL-1.0",
        # Cryptographic Autonomy License 1.0 (Combined Work Exception)
        "CAL-1.0-Combined-Work-Exception",
        # Caldera License
        "Caldera",
        # Caldera License (without preamble)
        "Caldera-no-preamble",
        # Catharon License
        "Catharon",
        # Computer Associates Trusted Open Source License 1.1
        "CATOSL-1.1",
        # Creative Commons Attribution 1.0 Generic
        "CC-BY-1.0",
        # Creative Commons Attribution 2.0 Generic
        "CC-BY-2.0",
        # Creative Commons Attribution 2.5 Generic
        "CC-BY-2.5",
        # Creative Commons Attribution 2.5 Australia
        "CC-BY-2.5-AU",
        # Creative Commons Attribution 3.0 Unported
        "CC-BY-3.0",
        # Creative Commons Attribution 3.0 Austria
        "CC-BY-3.0-AT",
        # Creative Commons Attribution 3.0 Australia
        "CC-BY-3.0-AU",
        # Creative Commons Attribution 3.0 Germany
        "CC-BY-3.0-DE",
        # Creative Commons Attribution 3.0 IGO
        "CC-BY-3.0-IGO",
        # Creative Commons Attribution 3.0 Netherlands
        "CC-BY-3.0-NL",
        # Creative Commons Attribution 3.0 United States
        "CC-BY-3.0-US",
        # Creative Commons Attribution 4.0 International
        "CC-BY-4.0",
        # Creative Commons Attribution Non Commercial 1.0 Generic
        "CC-BY-NC-1.0",
        # Creative Commons Attribution Non Commercial 2.0 Generic
        "CC-BY-NC-2.0",
        # Creative Commons Attribution Non Commercial 2.5 Generic
        "CC-BY-NC-2.5",
        # Creative Commons Attribution Non Commercial 3.0 Unported
        "CC-BY-NC-3.0",
        # Creative Commons Attribution Non Commercial 3.0 Germany
        "CC-BY-NC-3.0-DE",
        # Creative Commons Attribution Non Commercial 4.0 International
        "CC-BY-NC-4.0",
        # Creative Commons Attribution Non Commercial No Derivatives 1.0 Generic
        "CC-BY-NC-ND-1.0",
        # Creative Commons Attribution Non Commercial No Derivatives 2.0 Generic
        "CC-BY-NC-ND-2.0",
        # Creative Commons Attribution Non Commercial No Derivatives 2.5 Generic
        "CC-BY-NC-ND-2.5",
        # Creative Commons Attribution Non Commercial No Derivatives 3.0 Unported
        "CC-BY-NC-ND-3.0",
        # Creative Commons Attribution Non Commercial No Derivatives 3.0 Germany
        "CC-BY-NC-ND-3.0-DE",
        # Creative Commons Attribution Non Commercial No Derivatives 3.0 IGO
        "CC-BY-NC-ND-3.0-IGO",
        # Creative Commons Attribution Non Commercial No Derivatives 4.0 International
        "CC-BY-NC-ND-4.0",
        # Creative Commons Attribution Non Commercial Share Alike 1.0 Generic
        "CC-BY-NC-SA-1.0",
        # Creative Commons Attribution Non Commercial Share Alike 2.0 Generic
        "CC-BY-NC-SA-2.0",
        # Creative Commons Attribution Non Commercial Share Alike 2.0 Germany
        "CC-BY-NC-SA-2.0-DE",
        # Creative Commons Attribution-NonCommercial-ShareAlike 2.0 France
        "CC-BY-NC-SA-2.0-FR",
        # Creative Commons Attribution Non Commercial Share Alike 2.0 England and Wales
        "CC-BY-NC-SA-2.0-UK",
        # Creative Commons Attribution Non Commercial Share Alike 2.5 Generic
        "CC-BY-NC-SA-2.5",
        # Creative Commons Attribution Non Commercial Share Alike 3.0 Unported
        "CC-BY-NC-SA-3.0",
        # Creative Commons Attribution Non Commercial Share Alike 3.0 Germany
        "CC-BY-NC-SA-3.0-DE",
        # Creative Commons Attribution Non Commercial Share Alike 3.0 IGO
        "CC-BY-NC-SA-3.0-IGO",
        # Creative Commons Attribution Non Commercial Share Alike 4.0 International
        "CC-BY-NC-SA-4.0",
        # Creative Commons Attribution No Derivatives 1.0 Generic
        "CC-BY-ND-1.0",
        # Creative Commons Attribution No Derivatives 2.0 Generic
        "CC-BY-ND-2.0",
        # Creative Commons Attribution No Derivatives 2.5 Generic
        "CC-BY-ND-2.5",
        # Creative Commons Attribution No Derivatives 3.0 Unported
        "CC-BY-ND-3.0",
        # Creative Commons Attribution No Derivatives 3.0 Germany
        "CC-BY-ND-3.0-DE",
        # Creative Commons Attribution No Derivatives 4.0 International
        "CC-BY-ND-4.0",
        # Creative Commons Attribution Share Alike 1.0 Generic
        "CC-BY-SA-1.0",
        # Creative Commons Attribution Share Alike 2.0 Generic
        "CC-BY-SA-2.0",
        # Creative Commons Attribution Share Alike 2.0 England and Wales
        "CC-BY-SA-2.0-UK",
        # Creative Commons Attribution Share Alike 2.1 Japan
        "CC-BY-SA-2.1-JP",
        # Creative Commons Attribution Share Alike 2.5 Generic
        "CC-BY-SA-2.5",
        # Creative Commons Attribution Share Alike 3.0 Unported
        "CC-BY-SA-3.0",
        # Creative Commons Attribution Share Alike 3.0 Austria
        "CC-BY-SA-3.0-AT",
        # Creative Commons Attribution Share Alike 3.0 Germany
        "CC-BY-SA-3.0-DE",
        # Creative Commons Attribution-ShareAlike 3.0 IGO
        "CC-BY-SA-3.0-IGO",
        # Creative Commons Attribution Share Alike 4.0 International
        "CC-BY-SA-4.0",
        # Creative Commons Public Domain Dedication and Certification
        "CC-PDDC",
        # Creative Commons Zero v1.0 Universal
        "CC0-1.0",
        # Common Development and Distribution License 1.0
        "CDDL-1.0",
        # Common Development and Distribution License 1.1
        "CDDL-1.1",
        # Common Documentation License 1.0
        "CDL-1.0",
        # Community Data License Agreement Permissive 1.0
        "CDLA-Permissive-1.0",
        # Community Data License Agreement Permissive 2.0
        "CDLA-Permissive-2.0",
        # Community Data License Agreement Sharing 1.0
        "CDLA-Sharing-1.0",
        # CeCILL Free Software License Agreement v1.0
        "CECILL-1.0",
        # CeCILL Free Software License Agreement v1.1
        "CECILL-1.1",
        # CeCILL Free Software License Agreement v2.0
        "CECILL-2.0",
        # CeCILL Free Software License Agreement v2.1
        "CECILL-2.1",
        # CeCILL-B Free Software License Agreement
        "CECILL-B",
        # CeCILL-C Free Software License Agreement
        "CECILL-C",
        # CERN Open Hardware Licence v1.1
        "CERN-OHL-1.1",
        # CERN Open Hardware Licence v1.2
        "CERN-OHL-1.2",
        # CERN Open Hardware Licence Version 2 - Permissive
        "CERN-OHL-P-2.0",
        # CERN Open Hardware Licence Version 2 - Strongly Reciprocal
        "CERN-OHL-S-2.0",
        # CERN Open Hardware Licence Version 2 - Weakly Reciprocal
        "CERN-OHL-W-2.0",
        # CFITSIO License
        "CFITSIO",
        # check-cvs License
        "check-cvs",
        # Checkmk License
        "checkmk",
        # Clarified Artistic License
        "ClArtistic",
        # Clips License
        "Clips",
        # CMU Mach License
        "CMU-Mach",
        # CMU    Mach - no notices-in-documentation variant
        "CMU-Mach-nodoc",
        # CNRI Jython License
        "CNRI-Jython",
        # CNRI Python License
        "CNRI-Python",
        # CNRI Python Open Source GPL Compatible License Agreement
        "CNRI-Python-GPL-Compatible",
        # Copyfree Open Innovation License
        "COIL-1.0",
        # Community Specification License 1.0
        "Community-Spec-1.0",
        # Condor Public License v1.1
        "Condor-1.1",
        # copyleft-next 0.3.0
        "copyleft-next-0.3.0",
        # copyleft-next 0.3.1
        "copyleft-next-0.3.1",
        # Cornell Lossless JPEG License
        "Cornell-Lossless-JPEG",
        # Common Public Attribution License 1.0
        "CPAL-1.0",
        # Common Public License 1.0
        "CPL-1.0",
        # Code Project Open License 1.02
        "CPOL-1.02",
        # Cronyx License
        "Cronyx",
        # Crossword License
        "Crossword",
        # CrystalStacker License
        "CrystalStacker",
        # CUA Office Public License v1.0
        "CUA-OPL-1.0",
        # Cube License
        "Cube",
        # curl License
        "curl",
        # Common Vulnerability Enumeration ToU License
        "cve-tou",
        # Deutsche Freie Software Lizenz
        "D-FSL-1.0",
        # DEC 3-Clause License
        "DEC-3-Clause",
        # diffmark license
        "diffmark",
        # Data licence Germany – attribution – version 2.0
        "DL-DE-BY-2.0",
        # Data licence Germany – zero – version 2.0
        "DL-DE-ZERO-2.0",
        # DOC License
        "DOC",
        # DocBook Schema License
        "DocBook-Schema",
        # DocBook Stylesheet License
        "DocBook-Stylesheet",
        # DocBook XML License
        "DocBook-XML",
        # Dotseqn License
        "Dotseqn",
        # Detection Rule License 1.0
        "DRL-1.0",
        # Detection Rule License 1.1
        "DRL-1.1",
        # DSDP License
        "DSDP",
        # David M. Gay dtoa License
        "dtoa",
        # dvipdfm License
        "dvipdfm",
        # Educational Community License v1.0
        "ECL-1.0",
        # Educational Community License v2.0
        "ECL-2.0",
        # eCos license version 2.0
        "eCos-2.0",
        # Eiffel Forum License v1.0
        "EFL-1.0",
        # Eiffel Forum License v2.0
        "EFL-2.0",
        # eGenix.com Public License 1.1.0
        "eGenix",
        # Elastic License 2.0
        "Elastic-2.0",
        # Entessa Public License v1.0
        "Entessa",
        # EPICS Open License
        "EPICS",
        # Eclipse Public License 1.0
        "EPL-1.0",
        # Eclipse Public License 2.0
        "EPL-2.0",
        # Erlang Public License v1.1
        "ErlPL-1.1",
        # Etalab Open License 2.0
        "etalab-2.0",
        # EU DataGrid Software License
        "EUDatagrid",
        # European Union Public License 1.0
        "EUPL-1.0",
        # European Union Public License 1.1
        "EUPL-1.1",
        # European Union Public License 1.2
        "EUPL-1.2",
        # Eurosym License
        "Eurosym",
        # Fair License
        "Fair",
        # Fuzzy Bitmap License
        "FBM",
        # Fraunhofer FDK AAC Codec Library
        "FDK-AAC",
        # Ferguson Twofish License
        "Ferguson-Twofish",
        # Frameworx Open License 1.0
        "Frameworx-1.0",
        # FreeBSD Documentation License
        "FreeBSD-DOC",
        # FreeImage Public License v1.0
        "FreeImage",
        # FSF All Permissive License
        "FSFAP",
        # FSF All Permissive License (without Warranty)
        "FSFAP-no-warranty-disclaimer",
        # FSF Unlimited License
        "FSFUL",
        # FSF Unlimited License (with License Retention)
        "FSFULLR",
        # FSF Unlimited License (With License Retention and Warranty Disclaimer)
        "FSFULLRWD",
        # Freetype Project License
        "FTL",
        # Furuseth License
        "Furuseth",
        # fwlw License
        "fwlw",
        # Gnome GCR Documentation License
        "GCR-docs",
        # GD License
        "GD",
        # GNU Free Documentation License v1.1
        "GFDL-1.1",
        # GNU Free Documentation License v1.1 only - invariants
        "GFDL-1.1-invariants-only",
        # GNU Free Documentation License v1.1 or later - invariants
        "GFDL-1.1-invariants-or-later",
        # GNU Free Documentation License v1.1 only - no invariants
        "GFDL-1.1-no-invariants-only",
        # GNU Free Documentation License v1.1 or later - no invariants
        "GFDL-1.1-no-invariants-or-later",
        # GNU Free Documentation License v1.1 only
        "GFDL-1.1-only",
        # GNU Free Documentation License v1.1 or later
        "GFDL-1.1-or-later",
        # GNU Free Documentation License v1.2
        "GFDL-1.2",
        # GNU Free Documentation License v1.2 only - invariants
        "GFDL-1.2-invariants-only",
        # GNU Free Documentation License v1.2 or later - invariants
        "GFDL-1.2-invariants-or-later",
        # GNU Free Documentation License v1.2 only - no invariants
        "GFDL-1.2-no-invariants-only",
        # GNU Free Documentation License v1.2 or later - no invariants
        "GFDL-1.2-no-invariants-or-later",
        # GNU Free Documentation License v1.2 only
        "GFDL-1.2-only",
        # GNU Free Documentation License v1.2 or later
        "GFDL-1.2-or-later",
        # GNU Free Documentation License v1.3
        "GFDL-1.3",
        # GNU Free Documentation License v1.3 only - invariants
        "GFDL-1.3-invariants-only",
        # GNU Free Documentation License v1.3 or later - invariants
        "GFDL-1.3-invariants-or-later",
        # GNU Free Documentation License v1.3 only - no invariants
        "GFDL-1.3-no-invariants-only",
        # GNU Free Documentation License v1.3 or later - no invariants
        "GFDL-1.3-no-invariants-or-later",
        # GNU Free Documentation License v1.3 only
        "GFDL-1.3-only",
        # GNU Free Documentation License v1.3 or later
        "GFDL-1.3-or-later",
        # Giftware License
        "Giftware",
        # GL2PS License
        "GL2PS",
        # 3dfx Glide License
        "Glide",
        # Glulxe License
        "Glulxe",
        # Good Luck With That Public License
        "GLWTPL",
        # gnuplot License
        "gnuplot",
        # GNU General Public License v1.0 only
        "GPL-1.0",
        # GNU General Public License v1.0 or later
        "GPL-1.0+",
        # GNU General Public License v1.0 only
        "GPL-1.0-only",
        # GNU General Public License v1.0 or later
        "GPL-1.0-or-later",
        # GNU General Public License v2.0 only
        "GPL-2.0",
        # GNU General Public License v2.0 or later
        "GPL-2.0+",
        # GNU General Public License v2.0 only
        "GPL-2.0-only",
        # GNU General Public License v2.0 or later
        "GPL-2.0-or-later",
        # GNU General Public License v2.0 w/Autoconf exception
        "GPL-2.0-with-autoconf-exception",
        # GNU General Public License v2.0 w/Bison exception
        "GPL-2.0-with-bison-exception",
        # GNU General Public License v2.0 w/Classpath exception
        "GPL-2.0-with-classpath-exception",
        # GNU General Public License v2.0 w/Font exception
        "GPL-2.0-with-font-exception",
        # GNU General Public License v2.0 w/GCC Runtime Library exception
        "GPL-2.0-with-GCC-exception",
        # GNU General Public License v3.0 only
        "GPL-3.0",
        # GNU General Public License v3.0 or later
        "GPL-3.0+",
        # GNU General Public License v3.0 only
        "GPL-3.0-only",
        # GNU General Public License v3.0 or later
        "GPL-3.0-or-later",
        # GNU General Public License v3.0 w/Autoconf exception
        "GPL-3.0-with-autoconf-exception",
        # GNU General Public License v3.0 w/GCC Runtime Library exception
        "GPL-3.0-with-GCC-exception",
        # Graphics Gems License
        "Graphics-Gems",
        # gSOAP Public License v1.3b
        "gSOAP-1.3b",
        # gtkbook License
        "gtkbook",
        # Gutmann License
        "Gutmann",
        # Haskell Language Report License
        "HaskellReport",
        # hdparm License
        "hdparm",
        # HIDAPI License
        "HIDAPI",
        # Hippocratic License 2.1
        "Hippocratic-2.1",
        # Hewlett-Packard 1986 License
        "HP-1986",
        # Hewlett-Packard 1989 License
        "HP-1989",
        # Historical Permission Notice and Disclaimer
        "HPND",
        # Historical Permission Notice and Disclaimer - DEC variant
        "HPND-DEC",
        # Historical Permission Notice and Disclaimer - documentation variant
        "HPND-doc",
        # Historical Permission Notice and Disclaimer - documentation sell variant
        "HPND-doc-sell",
        # HPND with US Government export control warning
        "HPND-export-US",
        # HPND with US Government export control warning and acknowledgment
        "HPND-export-US-acknowledgement",
        # HPND with US Government export control warning and modification rqmt
        "HPND-export-US-modify",
        # HPND with US Government export control and 2 disclaimers
        "HPND-export2-US",
        # Historical Permission Notice and Disclaimer - Fenneberg-Livingston variant
        "HPND-Fenneberg-Livingston",
        # Historical Permission Notice and Disclaimer    - INRIA-IMAG variant
        "HPND-INRIA-IMAG",
        # Historical Permission Notice and Disclaimer - Intel variant
        "HPND-Intel",
        # Historical Permission Notice and Disclaimer - Kevlin Henney variant
        "HPND-Kevlin-Henney",
        # Historical Permission Notice and Disclaimer - Markus Kuhn variant
        "HPND-Markus-Kuhn",
        # Historical Permission Notice and Disclaimer - merchantability variant
        "HPND-merchantability-variant",
        # Historical Permission Notice and Disclaimer with MIT disclaimer
        "HPND-MIT-disclaimer",
        # Historical Permission Notice and Disclaimer - Netrek variant
        "HPND-Netrek",
        # Historical Permission Notice and Disclaimer - Pbmplus variant
        "HPND-Pbmplus",
        # Historical Permission Notice and Disclaimer - sell xserver variant with MIT disclaimer
        "HPND-sell-MIT-disclaimer-xserver",
        # Historical Permission Notice and Disclaimer - sell regexpr variant
        "HPND-sell-regexpr",
        # Historical Permission Notice and Disclaimer - sell variant
        "HPND-sell-variant",
        # HPND sell variant with MIT disclaimer
        "HPND-sell-variant-MIT-disclaimer",
        # HPND sell variant with MIT disclaimer - reverse
        "HPND-sell-variant-MIT-disclaimer-rev",
        # Historical Permission Notice and Disclaimer - University of California variant
        "HPND-UC",
        # Historical Permission Notice and Disclaimer - University of California, US export warning
        "HPND-UC-export-US",
        # HTML Tidy License
        "HTMLTIDY",
        # IBM PowerPC Initialization and Boot Software
        "IBM-pibs",
        # ICU License
        "ICU",
        # IEC    Code Components End-user licence agreement
        "IEC-Code-Components-EULA",
        # Independent JPEG Group License
        "IJG",
        # Independent JPEG Group License - short
        "IJG-short",
        # ImageMagick License
        "ImageMagick",
        # iMatix Standard Function Library Agreement
        "iMatix",
        # Imlib2 License
        "Imlib2",
        # Info-ZIP License
        "Info-ZIP",
        # Inner Net License v2.0
        "Inner-Net-2.0",
        # Intel Open Source License
        "Intel",
        # Intel ACPI Software License Agreement
        "Intel-ACPI",
        # Interbase Public License v1.0
        "Interbase-1.0",
        # IPA Font License
        "IPA",
        # IBM Public License v1.0
        "IPL-1.0",
        # ISC License
        "ISC",
        # ISC Veillard variant
        "ISC-Veillard",
        # Jam License
        "Jam",
        # JasPer License
        "JasPer-2.0",
        # JPL Image Use Policy
        "JPL-image",
        # Japan Network Information Center License
        "JPNIC",
        # JSON License
        "JSON",
        # Kastrup License
        "Kastrup",
        # Kazlib License
        "Kazlib",
        # Knuth CTAN License
        "Knuth-CTAN",
        # Licence Art Libre 1.2
        "LAL-1.2",
        # Licence Art Libre 1.3
        "LAL-1.3",
        # Latex2e License
        "Latex2e",
        # Latex2e with translated notice permission
        "Latex2e-translated-notice",
        # Leptonica License
        "Leptonica",
        # GNU Library General Public License v2 only
        "LGPL-2.0",
        # GNU Library General Public License v2 or later
        "LGPL-2.0+",
        # GNU Library General Public License v2 only
        "LGPL-2.0-only",
        # GNU Library General Public License v2 or later
        "LGPL-2.0-or-later",
        # GNU Lesser General Public License v2.1 only
        "LGPL-2.1",
        # GNU Lesser General Public License v2.1 or later
        "LGPL-2.1+",
        # GNU Lesser General Public License v2.1 only
        "LGPL-2.1-only",
        # GNU Lesser General Public License v2.1 or later
        "LGPL-2.1-or-later",
        # GNU Lesser General Public License v3.0 only
        "LGPL-3.0",
        # GNU Lesser General Public License v3.0 or later
        "LGPL-3.0+",
        # GNU Lesser General Public License v3.0 only
        "LGPL-3.0-only",
        # GNU Lesser General Public License v3.0 or later
        "LGPL-3.0-or-later",
        # Lesser General Public License For Linguistic Resources
        "LGPLLR",
        # libpng License
        "Libpng",
        # PNG Reference Library version 2
        "libpng-2.0",
        # libselinux public domain notice
        "libselinux-1.0",
        # libtiff License
        "libtiff",
        # libutil David Nugent License
        "libutil-David-Nugent",
        # Licence Libre du Québec – Permissive version 1.1
        "LiLiQ-P-1.1",
        # Licence Libre du Québec – Réciprocité version 1.1
        "LiLiQ-R-1.1",
        # Licence Libre du Québec – Réciprocité forte version 1.1
        "LiLiQ-Rplus-1.1",
        # Linux man-pages - 1 paragraph
        "Linux-man-pages-1-para",
        # Linux man-pages Copyleft
        "Linux-man-pages-copyleft",
        # Linux man-pages Copyleft - 2 paragraphs
        "Linux-man-pages-copyleft-2-para",
        # Linux man-pages Copyleft Variant
        "Linux-man-pages-copyleft-var",
        # Linux Kernel Variant of OpenIB.org license
        "Linux-OpenIB",
        # Common Lisp LOOP License
        "LOOP",
        # LPD Documentation License
        "LPD-document",
        # Lucent Public License Version 1.0
        "LPL-1.0",
        # Lucent Public License v1.02
        "LPL-1.02",
        # LaTeX Project Public License v1.0
        "LPPL-1.0",
        # LaTeX Project Public License v1.1
        "LPPL-1.1",
        # LaTeX Project Public License v1.2
        "LPPL-1.2",
        # LaTeX Project Public License v1.3a
        "LPPL-1.3a",
        # LaTeX Project Public License v1.3c
        "LPPL-1.3c",
        # lsof License
        "lsof",
        # Lucida Bitmap Fonts License
        "Lucida-Bitmap-Fonts",
        # LZMA SDK License (versions 9.11 to 9.20)
        "LZMA-SDK-9.11-to-9.20",
        # LZMA SDK License (versions 9.22 and beyond)
        "LZMA-SDK-9.22",
        # Mackerras 3-Clause License
        "Mackerras-3-Clause",
        # Mackerras 3-Clause - acknowledgment variant
        "Mackerras-3-Clause-acknowledgment",
        # magaz License
        "magaz",
        # mailprio License
        "mailprio",
        # MakeIndex License
        "MakeIndex",
        # Martin Birgmeier License
        "Martin-Birgmeier",
        # McPhee Slideshow License
        "McPhee-slideshow",
        # metamail License
        "metamail",
        # Minpack License
        "Minpack",
        # The MirOS Licence
        "MirOS",
        # MIT License
        "MIT",
        # MIT No Attribution
        "MIT-0",
        # Enlightenment License (e16)
        "MIT-advertising",
        # MIT Click License
        "MIT-Click",
        # CMU License
        "MIT-CMU",
        # enna License
        "MIT-enna",
        # feh License
        "MIT-feh",
        # MIT Festival Variant
        "MIT-Festival",
        # MIT Khronos - old variant
        "MIT-Khronos-old",
        # MIT License Modern Variant
        "MIT-Modern-Variant",
        # MIT Open Group variant
        "MIT-open-group",
        # MIT testregex Variant
        "MIT-testregex",
        # MIT Tom Wu Variant
        "MIT-Wu",
        # MIT +no-false-attribs license
        "MITNFA",
        # MMIXware License
        "MMIXware",
        # Motosoto License
        "Motosoto",
        # MPEG Software Simulation
        "MPEG-SSG",
        # mpi Permissive License
        "mpi-permissive",
        # mpich2 License
        "mpich2",
        # Mozilla Public License 1.0
        "MPL-1.0",
        # Mozilla Public License 1.1
        "MPL-1.1",
        # Mozilla Public License 2.0
        "MPL-2.0",
        # Mozilla Public License 2.0 (no copyleft exception)
        "MPL-2.0-no-copyleft-exception",
        # mplus Font License
        "mplus",
        # Microsoft Limited Public License
        "MS-LPL",
        # Microsoft Public License
        "MS-PL",
        # Microsoft Reciprocal License
        "MS-RL",
        # Matrix Template Library License
        "MTLL",
        # Mulan Permissive Software License, Version 1
        "MulanPSL-1.0",
        # Mulan Permissive Software License, Version 2
        "MulanPSL-2.0",
        # Multics License
        "Multics",
        # Mup License
        "Mup",
        # Nara Institute of Science and Technology License (2003)
        "NAIST-2003",
        # NASA Open Source Agreement 1.3
        "NASA-1.3",
        # Naumen Public License
        "Naumen",
        # Net Boolean Public License v1
        "NBPL-1.0",
        # NCBI Public Domain Notice
        "NCBI-PD",
        # Non-Commercial Government Licence
        "NCGL-UK-2.0",
        # NCL Source Code License
        "NCL",
        # University of Illinois/NCSA Open Source License
        "NCSA",
        # Net-SNMP License
        "Net-SNMP",
        # NetCDF license
        "NetCDF",
        # Newsletr License
        "Newsletr",
        # Nethack General Public License
        "NGPL",
        # NICTA Public Software License, Version 1.0
        "NICTA-1.0",
        # NIST Public Domain Notice
        "NIST-PD",
        # NIST Public Domain Notice with license fallback
        "NIST-PD-fallback",
        # NIST Software License
        "NIST-Software",
        # Norwegian Licence for Open Government Data (NLOD) 1.0
        "NLOD-1.0",
        # Norwegian Licence for Open Government Data (NLOD) 2.0
        "NLOD-2.0",
        # No Limit Public License
        "NLPL",
        # Nokia Open Source License
        "Nokia",
        # Netizen Open Source License
        "NOSL",
        # Noweb License
        "Noweb",
        # Netscape Public License v1.0
        "NPL-1.0",
        # Netscape Public License v1.1
        "NPL-1.1",
        # Non-Profit Open Software License 3.0
        "NPOSL-3.0",
        # NRL License
        "NRL",
        # NTP License
        "NTP",
        # NTP No Attribution
        "NTP-0",
        # Nunit License
        "Nunit",
        # Open Use of Data Agreement v1.0
        "O-UDA-1.0",
        # OAR License
        "OAR",
        # Open CASCADE Technology Public License
        "OCCT-PL",
        # OCLC Research Public License 2.0
        "OCLC-2.0",
        # Open Data Commons Open Database License v1.0
        "ODbL-1.0",
        # Open Data Commons Attribution License v1.0
        "ODC-By-1.0",
        # OFFIS License
        "OFFIS",
        # SIL Open Font License 1.0
        "OFL-1.0",
        # SIL Open Font License 1.0 with no Reserved Font Name
        "OFL-1.0-no-RFN",
        # SIL Open Font License 1.0 with Reserved Font Name
        "OFL-1.0-RFN",
        # SIL Open Font License 1.1
        "OFL-1.1",
        # SIL Open Font License 1.1 with no Reserved Font Name
        "OFL-1.1-no-RFN",
        # SIL Open Font License 1.1 with Reserved Font Name
        "OFL-1.1-RFN",
        # OGC Software License, Version 1.0
        "OGC-1.0",
        # Taiwan Open Government Data License, version 1.0
        "OGDL-Taiwan-1.0",
        # Open Government Licence - Canada
        "OGL-Canada-2.0",
        # Open Government Licence v1.0
        "OGL-UK-1.0",
        # Open Government Licence v2.0
        "OGL-UK-2.0",
        # Open Government Licence v3.0
        "OGL-UK-3.0",
        # Open Group Test Suite License
        "OGTSL",
        # Open LDAP Public License v1.1
        "OLDAP-1.1",
        # Open LDAP Public License v1.2
        "OLDAP-1.2",
        # Open LDAP Public License v1.3
        "OLDAP-1.3",
        # Open LDAP Public License v1.4
        "OLDAP-1.4",
        # Open LDAP Public License v2.0 (or possibly 2.0A and 2.0B)
        "OLDAP-2.0",
        # Open LDAP Public License v2.0.1
        "OLDAP-2.0.1",
        # Open LDAP Public License v2.1
        "OLDAP-2.1",
        # Open LDAP Public License v2.2
        "OLDAP-2.2",
        # Open LDAP Public License v2.2.1
        "OLDAP-2.2.1",
        # Open LDAP Public License 2.2.2
        "OLDAP-2.2.2",
        # Open LDAP Public License v2.3
        "OLDAP-2.3",
        # Open LDAP Public License v2.4
        "OLDAP-2.4",
        # Open LDAP Public License v2.5
        "OLDAP-2.5",
        # Open LDAP Public License v2.6
        "OLDAP-2.6",
        # Open LDAP Public License v2.7
        "OLDAP-2.7",
        # Open LDAP Public License v2.8
        "OLDAP-2.8",
        # Open Logistics Foundation License Version 1.3
        "OLFL-1.3",
        # Open Market License
        "OML",
        # OpenPBS v2.3 Software License
        "OpenPBS-2.3",
        # OpenSSL License
        "OpenSSL",
        # OpenSSL License - standalone
        "OpenSSL-standalone",
        # OpenVision License
        "OpenVision",
        # Open Public License v1.0
        "OPL-1.0",
        # United    Kingdom Open Parliament Licence v3.0
        "OPL-UK-3.0",
        # Open Publication License v1.0
        "OPUBL-1.0",
        # OSET Public License version 2.1
        "OSET-PL-2.1",
        # Open Software License 1.0
        "OSL-1.0",
        # Open Software License 1.1
        "OSL-1.1",
        # Open Software License 2.0
        "OSL-2.0",
        # Open Software License 2.1
        "OSL-2.1",
        # Open Software License 3.0
        "OSL-3.0",
        # PADL License
        "PADL",
        # The Parity Public License 6.0.0
        "Parity-6.0.0",
        # The Parity Public License 7.0.0
        "Parity-7.0.0",
        # Open Data Commons Public Domain Dedication & License 1.0
        "PDDL-1.0",
        # PHP License v3.0
        "PHP-3.0",
        # PHP License v3.01
        "PHP-3.01",
        # Pixar License
        "Pixar",
        # pkgconf License
        "pkgconf",
        # Plexus Classworlds License
        "Plexus",
        # pnmstitch License
        "pnmstitch",
        # PolyForm Noncommercial License 1.0.0
        "PolyForm-Noncommercial-1.0.0",
        # PolyForm Small Business License 1.0.0
        "PolyForm-Small-Business-1.0.0",
        # PostgreSQL License
        "PostgreSQL",
        # Peer Production License
        "PPL",
        # Python Software Foundation License 2.0
        "PSF-2.0",
        # psfrag License
        "psfrag",
        # psutils License
        "psutils",
        # Python License 2.0
        "Python-2.0",
        # Python License 2.0.1
        "Python-2.0.1",
        # Python ldap License
        "python-ldap",
        # Qhull License
        "Qhull",
        # Q Public License 1.0
        "QPL-1.0",
        # Q Public License 1.0 - INRIA 2004 variant
        "QPL-1.0-INRIA-2004",
        # radvd License
        "radvd",
        # Rdisc License
        "Rdisc",
        # Red Hat eCos Public License v1.1
        "RHeCos-1.1",
        # Reciprocal Public License 1.1
        "RPL-1.1",
        # Reciprocal Public License 1.5
        "RPL-1.5",
        # RealNetworks Public Source License v1.0
        "RPSL-1.0",
        # RSA Message-Digest License
        "RSA-MD",
        # Ricoh Source Code Public License
        "RSCPL",
        # Ruby License
        "Ruby",
        # Ruby pty extension license
        "Ruby-pty",
        # Sax Public Domain Notice
        "SAX-PD",
        # Sax Public Domain Notice 2.0
        "SAX-PD-2.0",
        # Saxpath License
        "Saxpath",
        # SCEA Shared Source License
        "SCEA",
        # Scheme Language Report License
        "SchemeReport",
        # Sendmail License
        "Sendmail",
        # Sendmail License 8.23
        "Sendmail-8.23",
        # SGI Free Software License B v1.0
        "SGI-B-1.0",
        # SGI Free Software License B v1.1
        "SGI-B-1.1",
        # SGI Free Software License B v2.0
        "SGI-B-2.0",
        # SGI OpenGL License
        "SGI-OpenGL",
        # SGP4 Permission Notice
        "SGP4",
        # Solderpad Hardware License v0.5
        "SHL-0.5",
        # Solderpad Hardware License, Version 0.51
        "SHL-0.51",
        # Simple Public License 2.0
        "SimPL-2.0",
        # Sun Industry Standards Source License v1.1
        "SISSL",
        # Sun Industry Standards Source License v1.2
        "SISSL-1.2",
        # SL License
        "SL",
        # Sleepycat License
        "Sleepycat",
        # Standard ML of New Jersey License
        "SMLNJ",
        # Secure Messaging Protocol Public License
        "SMPPL",
        # SNIA Public License 1.1
        "SNIA",
        # snprintf License
        "snprintf",
        # softSurfer License
        "softSurfer",
        # Soundex License
        "Soundex",
        # Spencer License 86
        "Spencer-86",
        # Spencer License 94
        "Spencer-94",
        # Spencer License 99
        "Spencer-99",
        # Sun Public License v1.0
        "SPL-1.0",
        # ssh-keyscan License
        "ssh-keyscan",
        # SSH OpenSSH license
        "SSH-OpenSSH",
        # SSH short notice
        "SSH-short",
        # SSLeay License - standalone
        "SSLeay-standalone",
        # Server Side Public License, v 1
        "SSPL-1.0",
        # Standard ML of New Jersey License
        "StandardML-NJ",
        # SugarCRM Public License v1.1.3
        "SugarCRM-1.1.3",
        # Sun PPP License
        "Sun-PPP",
        # Sun PPP License (2000)
        "Sun-PPP-2000",
        # SunPro License
        "SunPro",
        # Scheme Widget Library (SWL) Software License Agreement
        "SWL",
        # swrule License
        "swrule",
        # Symlinks License
        "Symlinks",
        # TAPR Open Hardware License v1.0
        "TAPR-OHL-1.0",
        # TCL/TK License
        "TCL",
        # TCP Wrappers License
        "TCP-wrappers",
        # TermReadKey License
        "TermReadKey",
        # Transitive Grace Period Public Licence 1.0
        "TGPPL-1.0",
        # 3D Slicer License v1.0
        "3D-Slicer-1.0",
        # threeparttable License
        "threeparttable",
        # TMate Open Source License
        "TMate",
        # TORQUE v2.5+ Software License v1.1
        "TORQUE-1.1",
        # Trusster Open Source License
        "TOSL",
        # Time::ParseDate License
        "TPDL",
        # THOR Public License 1.0
        "TPL-1.0",
        # TrustedQSL License
        "TrustedQSL",
        # Text-Tabs+Wrap License
        "TTWL",
        # TTYP0 License
        "TTYP0",
        # Technische Universitaet Berlin License 1.0
        "TU-Berlin-1.0",
        # Technische Universitaet Berlin License 2.0
        "TU-Berlin-2.0",
        # Ubuntu Font Licence v1.0
        "Ubuntu-font-1.0",
        # UCAR License
        "UCAR",
        # Upstream Compatibility License v1.0
        "UCL-1.0",
        # ulem License
        "ulem",
        # Michigan/Merit Networks License
        "UMich-Merit",
        # Unicode License v3
        "Unicode-3.0",
        # Unicode License Agreement - Data Files and Software (2015)
        "Unicode-DFS-2015",
        # Unicode License Agreement - Data Files and Software (2016)
        "Unicode-DFS-2016",
        # Unicode Terms of Use
        "Unicode-TOU",
        # UnixCrypt License
        "UnixCrypt",
        # The Unlicense
        "Unlicense",
        # Universal Permissive License v1.0
        "UPL-1.0",
        # Utah Raster Toolkit Run Length Encoded License
        "URT-RLE",
        # Vim License
        "Vim",
        # VOSTROM Public License for Open Source
        "VOSTROM",
        # Vovida Software License v1.0
        "VSL-1.0",
        # W3C Software Notice and License (2002-12-31)
        "W3C",
        # W3C Software Notice and License (1998-07-20)
        "W3C-19980720",
        # W3C Software Notice and Document License (2015-05-13)
        "W3C-20150513",
        # w3m License
        "w3m",
        # Sybase Open Watcom Public License 1.0
        "Watcom-1.0",
        # Widget Workshop License
        "Widget-Workshop",
        # Wsuipa License
        "Wsuipa",
        # Do What The F*ck You Want To Public License
        "WTFPL",
        # wxWindows Library License
        "wxWindows",
        # X11 License
        "X11",
        # X11 License Distribution Modification Variant
        "X11-distribute-modifications-variant",
        # X11 swapped final paragraphs
        "X11-swapped",
        # Xdebug License v 1.03
        "Xdebug-1.03",
        # Xerox License
        "Xerox",
        # Xfig License
        "Xfig",
        # XFree86 License 1.1
        "XFree86-1.1",
        # xinetd License
        "xinetd",
        # xkeyboard-config Zinoviev License
        "xkeyboard-config-Zinoviev",
        # xlock License
        "xlock",
        # X.Net License
        "Xnet",
        # XPP License
        "xpp",
        # XSkat License
        "XSkat",
        # xzoom License
        "xzoom",
        # Yahoo! Public License v1.0
        "YPL-1.0",
        # Yahoo! Public License v1.1
        "YPL-1.1",
        # Zed License
        "Zed",
        # Zeeff License
        "Zeeff",
        # Zend License v2.0
        "Zend-2.0",
        # Zimbra Public License v1.3
        "Zimbra-1.3",
        # Zimbra Public License v1.4
        "Zimbra-1.4",
        # zlib License
        "Zlib",
        # zlib/libpng License with Acknowledgement
        "zlib-acknowledgement",
        # Zope Public License 1.1
        "ZPL-1.1",
        # Zope Public License 2.0
        "ZPL-2.0",
        # Zope Public License 2.1
        "ZPL-2.1"
      ].freeze

      # License Acknowledgement - Declared licenses and concluded licenses represent two different stages in the licensing process within software development. Declared licenses refer to the initial intention of the software authors regarding the licensing terms under which their code is released. On the other hand, concluded licenses are the result of a comprehensive analysis of the project's codebase to identify and confirm the actual licenses of the components used, which may differ from the initially declared licenses. While declared licenses provide an upfront indication of the licensing intentions, concluded licenses offer a more thorough understanding of the actual licensing within a project, facilitating proper compliance and risk management. Observed licenses are defined in `@.evidence.licenses`. Observed licenses form the evidence necessary to substantiate a concluded license.
      LICENSE_ACKNOWLEDGEMENT = [
        # Declared licenses represent the initial intentions of authors regarding the licensing terms of their code.
        "declared",
        # Concluded licenses are verified and confirmed.
        "concluded"
      ].freeze

      # License Type
      LICENSE_TYPE = [
        # A license that grants use of software solely for the purpose of education or research.
        "academic",
        # A license covering use of software embedded in a specific piece of hardware.
        "appliance",
        # A Client Access License (CAL) allows client computers to access services provided by server software.
        "client-access",
        # A Concurrent User license (aka floating license) limits the number of licenses for a software application and licenses are shared among a larger number of users.
        "concurrent-user",
        # A license where the core of a computer's processor is assigned a specific number of points.
        "core-points",
        # A license for which consumption is measured by non-standard metrics.
        "custom-metric",
        # A license that covers a defined number of installations on computers and other types of devices.
        "device",
        # A license that grants permission to install and use software for trial purposes.
        "evaluation",
        # A license that grants access to the software to one or more pre-defined users.
        "named-user",
        # A license that grants access to the software on one or more pre-defined computers or devices.
        "node-locked",
        # An Original Equipment Manufacturer license that is delivered with hardware, cannot be transferred to other hardware, and is valid for the life of the hardware.
        "oem",
        # A license where the software is sold on a one-time basis and the licensee can use a copy of the software indefinitely.
        "perpetual",
        # A license where each installation consumes points per processor.
        "processor-points",
        # A license where the licensee pays a fee to use the software or service.
        "subscription",
        # A license that grants access to the software or service by a specified number of users.
        "user",
        # Another license type.
        "other"
      ].freeze

      # Mode - The mode of operation in which the cryptographic algorithm (block cipher) is used.
      ALGORITHM_MODE = [
        # Cipher block chaining
        "cbc",
        # Electronic codebook
        "ecb",
        # Counter with cipher block chaining message authentication code
        "ccm",
        # Galois/counter
        "gcm",
        # Cipher feedback
        "cfb",
        # Output feedback
        "ofb",
        # Counter
        "ctr",
        # Another mode of operation
        "other",
        # The mode of operation is not known
        "unknown"
      ].freeze

      # Output Type - Describes the type of data output.
      OUTPUT_TYPE = %w[
        artifact
        attestation
        log
        evidence
        metrics
        other
      ].freeze

      # Padding - The padding scheme that is used for the cryptographic algorithm.
      PADDING = [
        # Public Key Cryptography Standard: Password-Based Cryptography
        "pkcs5",
        # Public Key Cryptography Standard: Cryptographic Message Syntax
        "pkcs7",
        # Public Key Cryptography Standard: RSA Cryptography v1.5
        "pkcs1v15",
        # Optimal asymmetric encryption padding
        "oaep",
        # Raw
        "raw",
        # Another padding scheme
        "other",
        # The padding scheme is not known
        "unknown"
      ].freeze

      # Patch Type - Specifies the purpose for the patch including the resolution of defects, security issues, or new behavior or functionality.
      PATCH_TYPE = [
        # A patch which is not developed by the creators or maintainers of the software being patched. Refer to [https://en.wikipedia.org/wiki/Unofficial_patch](https://en.wikipedia.org/wiki/Unofficial_patch).
        "unofficial",
        # A patch which dynamically modifies runtime behavior. Refer to [https://en.wikipedia.org/wiki/Monkey_patch](https://en.wikipedia.org/wiki/Monkey_patch).
        "monkey",
        # A patch which takes code from a newer version of the software and applies it to older versions of the same software. Refer to [https://en.wikipedia.org/wiki/Backporting](https://en.wikipedia.org/wiki/Backporting).
        "backport",
        # A patch created by selectively applying commits from other versions or branches of the same software.
        "cherry-pick"
      ].freeze

      # Phase - A pre-defined phase in the product lifecycle.
      PHASE = [
        # BOM produced early in the development lifecycle containing an inventory of components and services that are proposed or planned to be used. The inventory may need to be procured, retrieved, or resourced prior to use.
        "design",
        # BOM consisting of information obtained prior to a build process and may contain source files and development artifacts and manifests. The inventory may need to be resolved and retrieved prior to use.
        "pre-build",
        # BOM consisting of information obtained during a build process where component inventory is available for use. The precise versions of resolved components are usually available at this time as well as the provenance of where the components were retrieved from.
        "build",
        # BOM consisting of information obtained after a build process has completed and the resulting components(s) are available for further analysis. Built components may exist as the result of a CI/CD process, may have been installed or deployed to a system or device, and may need to be retrieved or extracted from the system or device.
        "post-build",
        # BOM produced that represents inventory that is running and operational. This may include staging or production environments and will generally encompass multiple SBOMs describing the applications and operating system, along with HBOMs describing the hardware that makes up the system. Operations Bill of Materials (OBOM) can provide full-stack inventory of runtime environments, configurations, and additional dependencies.
        "operations",
        # BOM consisting of information observed through network discovery providing point-in-time enumeration of embedded, on-premise, and cloud-native services such as server applications, connected devices, microservices, and serverless functions.
        "discovery",
        # BOM containing inventory that will be, or has been retired from operations.
        "decommission"
      ].freeze

      # primitive - Cryptographic building blocks used in higher-level cryptographic systems and protocols. Primitives represent different cryptographic routines: deterministic random bit generators (drbg, e.g. CTR_DRBG from NIST SP800-90A-r1), message authentication codes (mac, e.g. HMAC-SHA-256), blockciphers (e.g. AES), streamciphers (e.g. Salsa20), signatures (e.g. ECDSA), hash functions (e.g. SHA-256), public-key encryption schemes (pke, e.g. RSA), extended output functions (xof, e.g. SHAKE256), key derivation functions (e.g. pbkdf2), key agreement algorithms (e.g. ECDH), key encapsulation mechanisms (e.g. ML-KEM), authenticated encryption (ae, e.g. AES-GCM) and the combination of multiple algorithms (combiner, e.g. SP800-56Cr2).
      PRIMITIVE = [
        # Deterministic Random Bit Generator (DRBG) is a type of pseudorandom number generator designed to produce a sequence of bits from an initial seed value. DRBGs are commonly used in cryptographic applications where reproducibility of random values is important.
        "drbg",
        # In cryptography, a Message Authentication Code (MAC) is information used for authenticating and integrity-checking a message.
        "mac",
        # A block cipher is a symmetric key algorithm that operates on fixed-size blocks of data. It encrypts or decrypts the data in block units, providing confidentiality. Block ciphers are widely used in various cryptographic modes and protocols for secure data transmission.
        "block-cipher",
        # A stream cipher is a symmetric key cipher where plaintext digits are combined with a pseudorandom cipher digit stream (keystream).
        "stream-cipher",
        # In cryptography, a signature is a digital representation of a message or data that proves its origin, identity, and integrity. Digital signatures are generated using cryptographic algorithms and are widely used for authentication and verification in secure communication.
        "signature",
        # A hash function is a mathematical algorithm that takes an input (or 'message') and produces a fixed-size string of characters, which is typically a hash value. Hash functions are commonly used in various cryptographic applications, including data integrity verification and password hashing.
        "hash",
        # Public Key Encryption (PKE) is a type of encryption that uses a pair of public and private keys for secure communication. The public key is used for encryption, while the private key is used for decryption. PKE is a fundamental component of public-key cryptography.
        "pke",
        # An XOF is an extendable output function that can take arbitrary input and creates a stream of output, up to a limit determined by the size of the internal state of the hash function that underlies the XOF.
        "xof",
        # A Key Derivation Function (KDF) derives key material from another source of entropy while preserving the entropy of the input.
        "kdf",
        # In cryptography, a key-agreement is a protocol whereby two or more parties agree on a cryptographic key in such a way that both influence the outcome.
        "key-agree",
        # A Key Encapsulation Mechanism (KEM) algorithm is a mechanism for transporting random keying material to a recipient using the recipient's public key.
        "kem",
        # Authenticated Encryption (AE) is a cryptographic process that provides both confidentiality and data integrity. It ensures that the encrypted data has not been tampered with and comes from a legitimate source. AE is commonly used in secure communication protocols.
        "ae",
        # A combiner aggregates many candidates for a cryptographic primitive and generates a new candidate for the same primitive.
        "combiner",
        # Another primitive type.
        "other",
        # The primitive is not known.
        "unknown"
      ].freeze

      # Protocol Type - The concrete protocol type.
      PROTOCOL_TYPE = [
        # Transport Layer Security
        "tls",
        # Secure Shell
        "ssh",
        # Internet Protocol Security
        "ipsec",
        # Internet Key Exchange
        "ike",
        # Secure Socket Tunneling Protocol
        "sstp",
        # Wi-Fi Protected Access
        "wpa",
        # Another protocol type
        "other",
        # The protocol type is not known
        "unknown"
      ].freeze

      # Related Crypto Material Type - The type for the related cryptographic material
      RELATED_CRYPTO_MATERIAL_TYPE = [
        # The confidential key of a key pair used in asymmetric cryptography.
        "private-key",
        # The non-confidential key of a key pair used in asymmetric cryptography.
        "public-key",
        # A key used to encrypt and decrypt messages in symmetric cryptography.
        "secret-key",
        # A piece of information, usually an octet string, which, when processed through a cryptographic algorithm, processes cryptographic data.
        "key",
        # The result of encryption performed on plaintext using an algorithm (or cipher).
        "ciphertext",
        # A cryptographic value that is calculated from the data and a key known only by the signer.
        "signature",
        # The output of the hash function.
        "digest",
        # A fixed-size random or pseudo-random value used as an input parameter for cryptographic algorithms.
        "initialization-vector",
        # A random or pseudo-random number that can only be used once in a cryptographic communication.
        "nonce",
        # The input to a pseudo-random number generator. Different seeds generate different pseudo-random sequences.
        "seed",
        # A value used in a cryptographic process, usually to ensure that the results of computations for one instance cannot be reused by an attacker.
        "salt",
        # A piece of data known only to the parties involved, in a secure communication.
        "shared-secret",
        # A message authentication code (MAC), sometimes known as an authentication tag, is a short piece of information used for authenticating and integrity-checking a message.
        "tag",
        # An unspecified collection of data with relevance to cryptographic activity.
        "additional-data",
        # A secret word, phrase, or sequence of characters used during authentication or authorization.
        "password",
        # Establishes the identity of a party to communication, usually in the form of cryptographic keys or passwords.
        "credential",
        # An object encapsulating a security identity.
        "token",
        # Another type of cryptographic asset.
        "other",
        # The type of cryptographic asset is not known.
        "unknown"
      ].freeze

      # Related Crypto Material State - The key state as defined by NIST SP 800-57.
      RELATED_CRYPTO_MATERIAL_STATE = %w[
        pre-activation
        active
        suspended
        deactivated
        compromised
        destroyed
      ].freeze

      # Response
      RESPONSE = [
        # Can not fix
        "can_not_fix",
        # Will not fix
        "will_not_fix",
        # Update to a different revision or release
        "update",
        # Revert to a previous revision or release
        "rollback",
        # There is a workaround available
        "workaround_available"
      ].freeze

      # Component Scope - Specifies the scope of the component. If scope is not specified, 'required' scope SHOULD be assumed by the consumer of the BOM.
      SCOPE = [
        # The component is required for runtime
        "required",
        # The component is optional at runtime. Optional components are components that are not capable of being called due to them not being installed or otherwise accessible by any means. Components that are installed but due to configuration or other restrictions are prohibited from being called must be scoped as 'required'.
        "optional",
        # Components that are excluded provide the ability to document component usage for test and other non-runtime purposes. Excluded components are not reachable within a call graph at runtime.
        "excluded"
      ].freeze

      # Method - Specifies the severity or risk scoring methodology or standard used.
      SCORE_METHOD = [
        # Common Vulnerability Scoring System v2.0
        "CVSSv2",
        # Common Vulnerability Scoring System v3.0
        "CVSSv3",
        # Common Vulnerability Scoring System v3.1
        "CVSSv31",
        # Common Vulnerability Scoring System v4.0
        "CVSSv4",
        # OWASP Risk Rating Methodology
        "OWASP",
        # Stakeholder Specific Vulnerability Categorization
        "SSVC",
        # Another severity or risk scoring methodology
        "other"
      ].freeze

      # Severity - Textual representation of the severity of the vulnerability adopted by the analysis method. If the analysis method uses values other than what is provided, the user is expected to translate appropriately.
      SEVERITY = [
        # The severity is not known
        "unknown",
        # None
        "none",
        # Informational warning.
        "info",
        # Low severity
        "low",
        # Medium severity
        "medium",
        # High severity
        "high",
        # Critical severity
        "critical"
      ].freeze

      SIGNATURE_ALGORITHM = %w[
        RS256
        RS384
        RS512
        PS256
        PS384
        PS512
        ES256
        ES384
        ES512
        Ed25519
        Ed448
        HS256
        HS384
        HS512
      ].freeze

      SIGNATURE_KEY_TYPE = %w[
        EC
        OKP
        RSA
      ].freeze

      SIGNATURE_EC_CRV = %w[
        P-256
        P-384
        P-521
      ].freeze

      SIGNATURE_OKP_CRV = %w[
        Ed25519
        Ed448
      ].freeze

      # Anonymous class from TaskType
      TASK_TYPE = [
        # A task that copies software or data used to accomplish other tasks in the workflow.
        "copy",
        # A task that clones a software repository into the workflow in order to retrieve its source code or data for use in a build step.
        "clone",
        # A task that checks source code for programmatic and stylistic errors.
        "lint",
        # A task that performs a scan against source code, or built or deployed components and services. Scans are typically run to gather or test for security vulnerabilities or policy compliance.
        "scan",
        # A task that merges changes or fixes into source code prior to a build step in the workflow.
        "merge",
        # A task that builds the source code, dependencies and/or data into an artifact that can be deployed to and executed on target systems.
        "build",
        # A task that verifies the functionality of a component or service.
        "test",
        # A task that delivers a built artifact to one or more target repositories or storage systems.
        "deliver",
        # A task that deploys a built artifact for execution on one or more target systems.
        "deploy",
        # A task that releases a built, versioned artifact to a target repository or distribution system.
        "release",
        # A task that cleans unnecessary tools, build artifacts and/or data from workflow storage.
        "clean",
        # A workflow task that does not match current task type definitions.
        "other"
      ].freeze

      # Technique - The technique used in this method of analysis.
      TECHNIQUE = %w[
        source-code-analysis
        binary-analysis
        manifest-analysis
        ast-fingerprint
        hash-comparison
        instrumentation
        dynamic-analysis
        filename
        attestation
        other
      ].freeze

      TRIGGER_TYPE = %w[
        manual
        api
        webhook
        scheduled
      ].freeze

      VOLUME_MODE = %w[
        filesystem
        block
      ].freeze
    end
  end
end
