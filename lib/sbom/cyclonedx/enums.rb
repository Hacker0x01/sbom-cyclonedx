# frozen_string_literal: true
# rbs_inline: enabled

module SBOM
  module Cyclonedx
    # TODO: Instead of using constants, make each value a subclass of its enum and each enum a subclass of some "Enum"
    # base class. This will allow us to use .is_a?, etc. to check for enum membership.

    # Access mode - Describes the read-write access control for the workspace relative to the owning resource instance.
    module AccessMode
      READ_ONLY = "read-only"
      READ_WRITE = "read-write"
      READ_WRITE_ONCE = "read-write-once"
      WRITE_ONCE = "write-once"
      WRITE_ONLY = "write-only"
    end

    # Activity - The type of activity that is part of a machine learning model development or operational lifecycle.
    module Activity
      # A model design including problem framing, goal definition and algorithm selection.
      DESIGN = "design"
      # Model data acquisition including search, selection and transfer.
      DATA_COLLECTION = "data-collection"
      # Model data preparation including data cleaning, labeling and conversion.
      DATA_PREPARATION = "data-preparation"
      # Model building, training and generalized tuning.
      TRAINING = "training"
      # Refining a trained model to produce desired outputs for a given problem space.
      FINE_TUNING = "fine-tuning"
      # Model validation including model output evaluation and testing.
      VALIDATION = "validation"
      # Explicit model deployment to a target hosting infrastructure.
      DEPLOYMENT = "deployment"
      # Generating an output response from a hosted model from a set of inputs.
      INFERENCE = "inference"
      # A lifecycle activity type whose description does not match currently defined values.
      OTHER = "other"
    end

    # The vulnerability status of a given version or range of versions of a product. The statuses 'affected' and 'unaffected' indicate that the version is affected or unaffected by the vulnerability. The status 'unknown' indicates that it is unknown or unspecified whether the given version is affected. There can be many reasons for an 'unknown' status, including that an investigation has not been undertaken or that a vendor has not disclosed the status.
    module AffectedStatus
      # The version is affected by the vulnerability.
      AFFECTED = "affected"
      # The version is not affected by the vulnerability.
      UNAFFECTED = "unaffected"
      # It is unknown (or unspecified) whether the given version is affected.
      UNKNOWN = "unknown"
    end

    # Anonymous class from AggregateType
    module AggregateType
      # The relationship is complete. No further relationships including constituent components, services, or dependencies are known to exist.
      COMPLETE = "complete"
      # The relationship is incomplete. Additional relationships exist and may include constituent components, services, or dependencies.
      INCOMPLETE = "incomplete"
      # The relationship is incomplete. Only relationships for first-party components, services, or their dependencies are represented.
      INCOMPLETE_FIRST_PARTY_ONLY = "incomplete_first_party_only"
      # The relationship is incomplete. Only relationships for first-party components, services, or their dependencies are represented, limited specifically to those that are proprietary.
      INCOMPLETE_FIRST_PARTY_PROPRIETARY_ONLY = "incomplete_first_party_proprietary_only"
      # The relationship is incomplete. Only relationships for first-party components, services, or their dependencies are represented, limited specifically to those that are opensource.
      INCOMPLETE_FIRST_PARTY_OPENSOURCE_ONLY = "incomplete_first_party_opensource_only"
      # The relationship is incomplete. Only relationships for third-party components, services, or their dependencies are represented.
      INCOMPLETE_THIRD_PARTY_ONLY = "incomplete_third_party_only"
      # The relationship is incomplete. Only relationships for third-party components, services, or their dependencies are represented, limited specifically to those that are proprietary.
      INCOMPLETE_THIRD_PARTY_PROPRIETARY_ONLY = "incomplete_third_party_proprietary_only"
      # The relationship is incomplete. Only relationships for third-party components, services, or their dependencies are represented, limited specifically to those that are opensource.
      INCOMPLETE_THIRD_PARTY_OPENSOURCE_ONLY = "incomplete_third_party_opensource_only"
      # The relationship may be complete or incomplete. This usually signifies a 'best-effort' to obtain constituent components, services, or dependencies but the completeness is inconclusive.
      UNKNOWN = "unknown"
      # The relationship completeness is not specified.
      NOT_SPECIFIED = "not_specified"
    end

    # Asset Type - Cryptographic assets occur in several forms. Algorithms and protocols are most commonly implemented in specialized cryptographic libraries. They may, however, also be 'hardcoded' in software components. Certificates and related cryptographic material like keys, tokens, secrets or passwords are other cryptographic assets to be modelled.
    module AssetType
      # Mathematical function commonly used for data encryption, authentication, and digital signatures.
      ALGORITHM = "algorithm"
      # An electronic document that is used to provide the identity or validate a public key.
      CERTIFICATE = "certificate"
      # A set of rules and guidelines that govern the behavior and communication with each other.
      PROTOCOL = "protocol"
      # Other cryptographic assets related to algorithms, certificates, and protocols such as keys and tokens.
      RELATED_CRYPTO_MATERIAL = "related-crypto-material"
    end

    # Certification Level
    module CertificationLevel
      # No certification obtained
      NONE = "none"
      # FIPS 140-1 Level 1
      FIPS140_1_L1 = "fips140-1-l1"
      # FIPS 140-1 Level 2
      FIPS140_1_L2 = "fips140-1-l2"
      # FIPS 140-1 Level 3
      FIPS140_1_L3 = "fips140-1-l3"
      # FIPS 140-1 Level 4
      FIPS140_1_L4 = "fips140-1-l4"
      # FIPS 140-2 Level 1
      FIPS140_2_L1 = "fips140-2-l1"
      # FIPS 140-2 Level 2
      FIPS140_2_L2 = "fips140-2-l2"
      # FIPS 140-2 Level 3
      FIPS140_2_L3 = "fips140-2-l3"
      # FIPS 140-2 Level 4
      FIPS140_2_L4 = "fips140-2-l4"
      # FIPS 140-3 Level 1
      FIPS140_3_L1 = "fips140-3-l1"
      # FIPS 140-3 Level 2
      FIPS140_3_L2 = "fips140-3-l2"
      # FIPS 140-3 Level 3
      FIPS140_3_L3 = "fips140-3-l3"
      # FIPS 140-3 Level 4
      FIPS140_3_L4 = "fips140-3-l4"
      # Common Criteria - Evaluation Assurance Level 1
      CC_EAL1 = "cc-eal1"
      # Common Criteria - Evaluation Assurance Level 1 (Augmented)
      CC_EAL1_PLUS = "cc-eal1+"
      # Common Criteria - Evaluation Assurance Level 2
      CC_EAL2 = "cc-eal2"
      # Common Criteria - Evaluation Assurance Level 2 (Augmented)
      CC_EAL2_PLUS = "cc-eal2+"
      # Common Criteria - Evaluation Assurance Level 3
      CC_EAL3 = "cc-eal3"
      # Common Criteria - Evaluation Assurance Level 3 (Augmented)
      CC_EAL3_PLUS = "cc-eal3+"
      # Common Criteria - Evaluation Assurance Level 4
      CC_EAL4 = "cc-eal4"
      # Common Criteria - Evaluation Assurance Level 4 (Augmented)
      CC_EAL4_PLUS = "cc-eal4+"
      # Common Criteria - Evaluation Assurance Level 5
      CC_EAL5 = "cc-eal5"
      # Common Criteria - Evaluation Assurance Level 5 (Augmented)
      CC_EAL5_PLUS = "cc-eal5+"
      # Common Criteria - Evaluation Assurance Level 6
      CC_EAL6 = "cc-eal6"
      # Common Criteria - Evaluation Assurance Level 6 (Augmented)
      CC_EAL6_PLUS = "cc-eal6+"
      # Common Criteria - Evaluation Assurance Level 7
      CC_EAL7 = "cc-eal7"
      # Common Criteria - Evaluation Assurance Level 7 (Augmented)
      CC_EAL7_PLUS = "cc-eal7+"
      # Another certification
      OTHER = "other"
      # The certification level is not known
      UNKNOWN = "unknown"
    end

    # Component Type - Specifies the type of component. For software components, classify as application if no more specific appropriate classification is available or cannot be determined for the component.
    module ComponentType
      # A software application. Refer to [https://en.wikipedia.org/wiki/Application_software](https://en.wikipedia.org/wiki/Application_software) for information about applications.
      APPLICATION = "application"
      # A software framework. Refer to [https://en.wikipedia.org/wiki/Software_framework](https://en.wikipedia.org/wiki/Software_framework) for information on how frameworks vary slightly from libraries.
      FRAMEWORK = "framework"
      # A software library. Refer to [https://en.wikipedia.org/wiki/Library_(computing)](https://en.wikipedia.org/wiki/Library_(computing)) for information about libraries. All third-party and open source reusable components will likely be a library. If the library also has key features of a framework, then it should be classified as a framework. If not, or is unknown, then specifying library is recommended.
      LIBRARY = "library"
      # A packaging and/or runtime format, not specific to any particular technology, which isolates software inside the container from software outside of a container through virtualization technology. Refer to [https://en.wikipedia.org/wiki/OS-level_virtualization](https://en.wikipedia.org/wiki/OS-level_virtualization).
      CONTAINER = "container"
      # A runtime environment which interprets or executes software. This may include runtimes such as those that execute bytecode or low-code/no-code application platforms.
      PLATFORM = "platform"
      # A software operating system without regard to deployment model (i.e. installed on physical hardware, virtual machine, image, etc) Refer to [https://en.wikipedia.org/wiki/Operating_system](https://en.wikipedia.org/wiki/Operating_system).
      OPERATING_SYSTEM = "operating-system"
      # A hardware device such as a processor or chip-set. A hardware device containing firmware SHOULD include a component for the physical hardware itself and another component of type 'firmware' or 'operating-system' (whichever is relevant), describing information about the software running on the device. See also the list of [known device properties](https://github.com/CycloneDX/cyclonedx-property-taxonomy/blob/main/cdx/device.md).
      DEVICE = "device"
      # A special type of software that operates or controls a particular type of device. Refer to [https://en.wikipedia.org/wiki/Device_driver](https://en.wikipedia.org/wiki/Device_driver).
      DEVICE_DRIVER = "device-driver"
      # A special type of software that provides low-level control over a device's hardware. Refer to [https://en.wikipedia.org/wiki/Firmware](https://en.wikipedia.org/wiki/Firmware).
      FIRMWARE = "firmware"
      # A computer file. Refer to [https://en.wikipedia.org/wiki/Computer_file](https://en.wikipedia.org/wiki/Computer_file) for information about files.
      FILE = "file"
      # A model based on training data that can make predictions or decisions without being explicitly programmed to do so.
      MACHINE_LEARNING_MODEL = "machine-learning-model"
      # A collection of discrete values that convey information.
      DATA = "data"
      # A cryptographic asset including algorithms, protocols, certificates, keys, tokens, and secrets.
      CRYPTOGRAPHIC_ASSET = "cryptographic-asset"
    end

    # Cryptographic function
    module CryptoFunction
      GENERATE = "generate"
      KEYGEN = "keygen"
      ENCRYPT = "encrypt"
      DECRYPT = "decrypt"
      DIGEST = "digest"
      TAG = "tag"
      KEYDERIVE = "keyderive"
      SIGN = "sign"
      VERIFY = "verify"
      ENCAPSULATE = "encapsulate"
      DECAPSULATE = "decapsulate"
      OTHER = "other"
      UNKNOWN = "unknown"
    end

    # Data flow direction - Specifies the flow direction of the data. Direction is relative to the service.
    module DataFlowDirection
      # Data that enters a service.
      INBOUND = "inbound"
      # Data that exits a service.
      OUTBOUND = "outbound"
      # Data flows in and out of the service.
      BI_DIRECTIONAL = "bi-directional"
      # The directional flow of data is not known.
      UNKNOWN = "unknown"
    end

    module ComponentDataType
      # Any type of code, code snippet, or data-as-code.
      SOURCE_CODE = "source-code"
      # Parameters or settings that may be used by other components.
      CONFIGURATION = "configuration"
      # A collection of data.
      DATASET = "dataset"
      # Data that can be used to create new instances of what the definition defines.
      DEFINITION = "definition"
      # Any other type of data that does not fit into existing definitions.
      OTHER = "other"
    end

    # Energy Source - The energy source for the energy provider.
    module EnergySource
      # Energy produced by types of coal.
      COAL = "coal"
      # Petroleum products (primarily crude oil and its derivative fuel oils).
      OIL = "oil"
      # Hydrocarbon gas liquids (HGL) that occur as gases at atmospheric pressure and as liquids under higher pressures including Natural gas (C5H12 and heavier), Ethane (C2H6), Propane (C3H8), etc.
      NATURAL_GAS = "natural-gas"
      # Energy produced from the cores of atoms (i.e., through nuclear fission or fusion).
      NUCLEAR = "nuclear"
      # Energy produced from moving air.
      WIND = "wind"
      # Energy produced from the sun (i.e., solar radiation).
      SOLAR = "solar"
      # Energy produced from heat within the earth.
      GEOTHERMAL = "geothermal"
      # Energy produced from flowing water.
      HYDROPOWER = "hydropower"
      # Liquid fuels produced from biomass feedstocks (i.e., organic materials such as plants or animals).
      BIOFUEL = "biofuel"
      # The energy source is unknown.
      UNKNOWN = "unknown"
      # An energy source that is not listed.
      OTHER = "other"
    end

    # Execution Environment - The target and execution environment in which the algorithm is implemented in.
    module ExecutionEnvironment
      # A software implementation running in plain unencrypted RAM.
      SOFTWARE_PLAIN_RAM = "software-plain-ram"
      # A software implementation running in encrypted RAM.
      SOFTWARE_ENCRYPTED_RAM = "software-encrypted-ram"
      # A software implementation running in a trusted execution environment.
      SOFTWARE_TEE = "software-tee"
      # A hardware implementation.
      HARDWARE = "hardware"
      # Another implementation environment.
      OTHER = "other"
      # The execution environment is not known.
      UNKNOWN = "unknown"
    end

    module ExternalReferenceType
      # Version Control System
      VCS = "vcs"
      # Issue or defect tracking system, or an Application Lifecycle Management (ALM) system
      ISSUE_TRACKER = "issue-tracker"
      # Website
      WEBSITE = "website"
      # Security advisories
      ADVISORIES = "advisories"
      # Bill of Materials (SBOM, OBOM, HBOM, SaaSBOM, etc)
      BOM = "bom"
      # Mailing list or discussion group
      MAILING_LIST = "mailing-list"
      # Social media account
      SOCIAL = "social"
      # Real-time chat platform
      CHAT = "chat"
      # Documentation, guides, or how-to instructions
      DOCUMENTATION = "documentation"
      # Community or commercial support
      SUPPORT = "support"
      # The location where the source code distributable can be obtained. This is often an archive format such as zip or tgz. The source-distribution type complements use of the version control (vcs) type.
      SOURCE_DISTRIBUTION = "source-distribution"
      # Direct or repository download location
      DISTRIBUTION = "distribution"
      # The location where a component was published to. This is often the same as \"distribution\" but may also include specialized publishing processes that act as an intermediary.
      DISTRIBUTION_INTAKE = "distribution-intake"
      # The reference to the license file. If a license URL has been defined in the license node, it should also be defined as an external reference for completeness.
      LICENSE = "license"
      # Build-system specific meta file (i.e. pom.xml, package.json, .nuspec, etc)
      BUILD_META = "build-meta"
      # Reference to an automated build system
      BUILD_SYSTEM = "build-system"
      # Reference to release notes
      RELEASE_NOTES = "release-notes"
      # Specifies a way to contact the maintainer, supplier, or provider in the event of a security incident. Common URIs include links to a disclosure procedure, a mailto (RFC-2368) that specifies an email address, a tel (RFC-3966) that specifies a phone number, or dns (RFC-4501) that specifies the records containing DNS Security TXT.
      SECURITY_CONTACT = "security-contact"
      # A model card describes the intended uses of a machine learning model, potential limitations, biases, ethical considerations, training parameters, datasets used to train the model, performance metrics, and other relevant data useful for ML transparency.
      MODEL_CARD = "model-card"
      # A record of events that occurred in a computer system or application, such as problems, errors, or information on current operations.
      LOG = "log"
      # Parameters or settings that may be used by other components or services.
      CONFIGURATION = "configuration"
      # Information used to substantiate a claim.
      EVIDENCE = "evidence"
      # Describes how a component or service was manufactured or deployed.
      FORMULATION = "formulation"
      # Human or machine-readable statements containing facts, evidence, or testimony.
      ATTESTATION = "attestation"
      # An enumeration of identified weaknesses, threats, and countermeasures, dataflow diagram (DFD), attack tree, and other supporting documentation in human-readable or machine-readable format.
      THREAT_MODEL = "threat-model"
      # The defined assumptions, goals, and capabilities of an adversary.
      ADVERSARY_MODEL = "adversary-model"
      # Identifies and analyzes the potential of future events that may negatively impact individuals, assets, and/or the environment. Risk assessments may also include judgments on the tolerability of each risk.
      RISK_ASSESSMENT = "risk-assessment"
      # A Vulnerability Disclosure Report (VDR) which asserts the known and previously unknown vulnerabilities that affect a component, service, or product including the analysis and findings describing the impact (or lack of impact) that the reported vulnerability has on a component, service, or product.
      VULNERABILITY_ASSERTION = "vulnerability-assertion"
      # A Vulnerability Exploitability eXchange (VEX) which asserts the known vulnerabilities that do not affect a product, product family, or organization, and optionally the ones that do. The VEX should include the analysis and findings describing the impact (or lack of impact) that the reported vulnerability has on the product, product family, or organization.
      EXPLOITABILITY_STATEMENT = "exploitability-statement"
      # Results from an authorized simulated cyberattack on a component or service, otherwise known as a penetration test.
      PENTEST_REPORT = "pentest-report"
      # SARIF or proprietary machine or human-readable report for which static analysis has identified code quality, security, and other potential issues with the source code.
      STATIC_ANALYSIS_REPORT = "static-analysis-report"
      # Dynamic analysis report that has identified issues such as vulnerabilities and misconfigurations.
      DYNAMIC_ANALYSIS_REPORT = "dynamic-analysis-report"
      # Report generated by analyzing the call stack of a running application.
      RUNTIME_ANALYSIS_REPORT = "runtime-analysis-report"
      # Report generated by Software Composition Analysis (SCA), container analysis, or other forms of component analysis.
      COMPONENT_ANALYSIS_REPORT = "component-analysis-report"
      # Report containing a formal assessment of an organization, business unit, or team against a maturity model.
      MATURITY_REPORT = "maturity-report"
      # Industry, regulatory, or other certification from an accredited (if applicable) certification body.
      CERTIFICATION_REPORT = "certification-report"
      # Code or configuration that defines and provisions virtualized infrastructure, commonly referred to as Infrastructure as Code (IaC).
      CODIFIED_INFRASTRUCTURE = "codified-infrastructure"
      # Report or system in which quality metrics can be obtained.
      QUALITY_METRICS = "quality-metrics"
      # Plans of Action and Milestones (POA&M) complement an \"attestation\" external reference. POA&M is defined by NIST as a \"document that identifies tasks needing to be accomplished. It details resources required to accomplish the elements of the plan, any milestones in meeting the tasks and scheduled completion dates for the milestones\".
      POAM = "poam"
      # An e-signature is commonly a scanned representation of a written signature or a stylized script of the person's name.
      ELECTRONIC_SIGNATURE = "electronic-signature"
      # A signature that leverages cryptography, typically public/private key pairs, which provides strong authenticity verification.
      DIGITAL_SIGNATURE = "digital-signature"
      # Document that complies with [RFC 9116](https://www.ietf.org/rfc/rfc9116.html) (A File Format to Aid in Security Vulnerability Disclosure)
      RFC_9116 = "rfc-9116"
      # Use this if no other types accurately describe the purpose of the external reference.
      OTHER = "other"
    end

    # Field - The identity field of the component which the evidence describes.
    module Field
      GROUP = "group"
      NAME = "name"
      VERSION = "version"
      PURL = "purl"
      CPE = "cpe"
      OMNIBOR_ID = "omniborId"
      SWHID = "swhid"
      SWID = "swid"
      HASH = "hash"
    end

    # Hash Algorithm - The algorithm that generated the hash value.
    module HashAlg
      MD5 = "MD5"
      SHA_1 = "SHA-1"
      SHA_256 = "SHA-256"
      SHA_384 = "SHA-384"
      SHA_512 = "SHA-512"
      SHA3_256 = "SHA3-256"
      SHA3_384 = "SHA3-384"
      SHA3_512 = "SHA3-512"
      BLAKE2B_256 = "BLAKE2b-256"
      BLAKE2B_384 = "BLAKE2b-384"
      BLAKE2B_512 = "BLAKE2b-512"
      BLAKE3 = "BLAKE3"
    end

    # Impact Analysis Justification - The rationale of why the impact analysis state was asserted.
    module ImpactAnalysisJustification
      # The code has been removed or tree-shaked.
      CODE_NOT_PRESENT = "code_not_present"
      # The vulnerable code is not invoked at runtime.
      CODE_NOT_REACHABLE = "code_not_reachable"
      # Exploitability requires a configurable option to be set/unset.
      REQUIRES_CONFIGURATION = "requires_configuration"
      # Exploitability requires a dependency that is not present.
      REQUIRES_DEPENDENCY = "requires_dependency"
      # Exploitability requires a certain environment which is not present.
      REQUIRES_ENVIRONMENT = "requires_environment"
      # Exploitability requires a compiler flag to be set/unset.
      PROTECTED_BY_COMPILER = "protected_by_compiler"
      # Exploits are prevented at runtime.
      PROTECTED_AT_RUNTIME = "protected_at_runtime"
      # Attacks are blocked at physical, logical, or network perimeter.
      PROTECTED_AT_PERIMETER = "protected_at_perimeter"
      # Preventative measures have been implemented that reduce the likelihood and/or impact of the vulnerability.
      PROTECTED_BY_MITIGATING_CONTROL = "protected_by_mitigating_control"
    end

    # Impact Analysis State - Declares the current state of an occurrence of a vulnerability, after automated or manual analysis.
    module ImpactAnalysisState
      # The vulnerability has been remediated.
      RESOLVED = "resolved"
      # The vulnerability has been remediated and evidence of the changes are provided in the affected components pedigree containing verifiable commit history and/or diff(s).
      RESOLVED_WITH_PEDIGREE = "resolved_with_pedigree"
      # The vulnerability may be directly or indirectly exploitable.
      EXPLOITABLE = "exploitable"
      # The vulnerability is being investigated.
      IN_TRIAGE = "in_triage"
      # The vulnerability is not specific to the component or service and was falsely identified or associated.
      FALSE_POSITIVE = "false_positive"
      # The component or service is not affected by the vulnerability. Justification should be specified for all not_affected cases.
      NOT_AFFECTED = "not_affected"
    end

    # Implementation platform - The target platform for which the algorithm is implemented. The implementation can be 'generic', running on any platform or for a specific platform.
    module ImplementationPlatform
      GENERIC = "generic"
      X86_32 = "x86_32"
      X86_64 = "x86_64"
      ARMV7_A = "armv7-a"
      ARMV7_M = "armv7-m"
      ARMV8_A = "armv8-a"
      ARMV8_M = "armv8-m"
      ARMV9_A = "armv9-a"
      ARMV9_M = "armv9-m"
      S390X = "s390x"
      PPC64 = "ppc64"
      PPC64LE = "ppc64le"
      OTHER = "other"
      UNKNOWN = "unknown"
    end

    # Issue Type - Specifies the type of issue
    module IssueType
      # A fault, flaw, or bug in software.
      DEFECT = "defect"
      # A new feature or behavior in software.
      ENHANCEMENT = "enhancement"
      # A special type of defect which impacts security.
      SECURITY = "security"
    end

    # Learning Type - Learning types describing the learning problem or hybrid learning problem.
    module LearningType
      # Supervised machine learning involves training an algorithm on labeled data to predict or classify new data based on the patterns learned from the labeled examples.
      SUPERVISED = "supervised"
      # Unsupervised machine learning involves training algorithms on unlabeled data to discover patterns, structures, or relationships without explicit guidance, allowing the model to identify inherent structures or clusters within the data.
      UNSUPERVISED = "unsupervised"
      # Reinforcement learning is a type of machine learning where an agent learns to make decisions by interacting with an environment to maximize cumulative rewards, through trial and error.
      REINFORCEMENT_LEARNING = "reinforcement-learning"
      # Semi-supervised machine learning utilizes a combination of labeled and unlabeled data during training to improve model performance, leveraging the benefits of both supervised and unsupervised learning techniques.
      SEMI_SUPERVISED = "semi-supervised"
      # Self-supervised machine learning involves training models to predict parts of the input data from other parts of the same data, without requiring external labels, enabling learning from large amounts of unlabeled data.
      SELF_SUPERVISED = "self-supervised"
    end

    # License ID (SPDX) - A valid SPDX license identifier. If specified, this value must be one of the enumeration of valid SPDX license identifiers defined in the spdx.schema.json (or spdx.xml) subschema which is synchronized with the official SPDX license list.
    module LicenseID # rubocop:disable Metrics/ModuleLength
      # Attribution Assurance License
      AAL = "AAL"
      # Abstyles License
      ABSTYLES = "Abstyles"
      # AdaCore Doc License
      ADACORE_DOC = "AdaCore-doc"
      # Adobe Systems Incorporated Source Code License Agreement
      ADOBE_2006 = "Adobe-2006"
      # Adobe Display PostScript License
      ADOBE_DISPLAY_POSTSCRIPT = "Adobe-Display-PostScript"
      # Adobe Glyph List License
      ADOBE_GLYPH = "Adobe-Glyph"
      # Adobe Utopia Font License
      ADOBE_UTOPIA = "Adobe-Utopia"
      # Amazon Digital Services License
      ADSL = "ADSL"
      # Academic Free License v1.1
      AFL_1_1 = "AFL-1.1"
      # Academic Free License v1.2
      AFL_1_2 = "AFL-1.2"
      # Academic Free License v2.0
      AFL_2_0 = "AFL-2.0"
      # Academic Free License v2.1
      AFL_2_1 = "AFL-2.1"
      # Academic Free License v3.0
      AFL_3_0 = "AFL-3.0"
      # Afmparse License
      AFMPARSE = "Afmparse"
      # Affero General Public License v1.0
      AGPL_1_0 = "AGPL-1.0"
      # Affero General Public License v1.0 only
      AGPL_1_0_ONLY = "AGPL-1.0-only"
      # Affero General Public License v1.0 or later
      AGPL_1_0_OR_LATER = "AGPL-1.0-or-later"
      # GNU Affero General Public License v3.0
      AGPL_3_0 = "AGPL-3.0"
      # GNU Affero General Public License v3.0 only
      AGPL_3_0_ONLY = "AGPL-3.0-only"
      # GNU Affero General Public License v3.0 or later
      AGPL_3_0_OR_LATER = "AGPL-3.0-or-later"
      # Aladdin Free Public License
      ALADDIN = "Aladdin"
      # AMD newlib License
      AMD_NEWLIB = "AMD-newlib"
      # AMD's plpa_map.c License
      AMDPLPA = "AMDPLPA"
      # Apple MIT License
      AML = "AML"
      # AML glslang variant License
      AML_GLSLANG = "AML-glslang"
      # Academy of Motion Picture Arts and Sciences BSD
      AMPAS = "AMPAS"
      # ANTLR Software Rights Notice
      ANTLR_PD = "ANTLR-PD"
      # ANTLR Software Rights Notice with license fallback
      ANTLR_PD_FALLBACK = "ANTLR-PD-fallback"
      # Any OSI License
      ANY_OSI = "any-OSI"
      # Apache License 1.0
      APACHE_1_0 = "Apache-1.0"
      # Apache License 1.1
      APACHE_1_1 = "Apache-1.1"
      # Apache License 2.0
      APACHE_2_0 = "Apache-2.0"
      # Adobe Postscript AFM License
      APAFML = "APAFML"
      # Adaptive Public License 1.0
      APL_1_0 = "APL-1.0"
      # App::s2p License
      APP_S2P = "App-s2p"
      # Apple Public Source License 1.0
      APSL_1_0 = "APSL-1.0"
      # Apple Public Source License 1.1
      APSL_1_1 = "APSL-1.1"
      # Apple Public Source License 1.2
      APSL_1_2 = "APSL-1.2"
      # Apple Public Source License 2.0
      APSL_2_0 = "APSL-2.0"
      # Arphic Public License
      ARPHIC_1999 = "Arphic-1999"
      # Artistic License 1.0
      ARTISTIC_1_0 = "Artistic-1.0"
      # Artistic License 1.0 w/clause 8
      ARTISTIC_1_0_CL8 = "Artistic-1.0-cl8"
      # Artistic License 1.0 (Perl)
      ARTISTIC_1_0_PERL = "Artistic-1.0-Perl"
      # Artistic License 2.0
      ARTISTIC_2_0 = "Artistic-2.0"
      # ASWF Digital Assets License version 1.0
      ASWF_DIGITAL_ASSETS_1_0 = "ASWF-Digital-Assets-1.0"
      # ASWF Digital Assets License 1.1
      ASWF_DIGITAL_ASSETS_1_1 = "ASWF-Digital-Assets-1.1"
      # Baekmuk License
      BAEKMUK = "Baekmuk"
      # Bahyph License
      BAHYPH = "Bahyph"
      # Barr License
      BARR = "Barr"
      # bcrypt Solar Designer License
      BCRYPT_SOLAR_DESIGNER = "bcrypt-Solar-Designer"
      # Beerware License
      BEERWARE = "Beerware"
      # Bitstream Charter Font License
      BITSTREAM_CHARTER = "Bitstream-Charter"
      # Bitstream Vera Font License
      BITSTREAM_VERA = "Bitstream-Vera"
      # BitTorrent Open Source License v1.0
      BITTORRENT_1_0 = "BitTorrent-1.0"
      # BitTorrent Open Source License v1.1
      BITTORRENT_1_1 = "BitTorrent-1.1"
      # SQLite Blessing
      BLESSING = "blessing"
      # Blue Oak Model License 1.0.0
      BLUEOAK_1_0_0 = "BlueOak-1.0.0"
      # Boehm-Demers-Weiser GC License
      BOEHM_GC = "Boehm-GC"
      # Borceux license
      BORCEUX = "Borceux"
      # Brian Gladman 2-Clause License
      BRIAN_GLADMAN_2_CLAUSE = "Brian-Gladman-2-Clause"
      # Brian Gladman 3-Clause License
      BRIAN_GLADMAN_3_CLAUSE = "Brian-Gladman-3-Clause"
      # BSD Zero Clause License
      BSD_0_CLAUSE = "0BSD"
      # BSD 1-Clause License
      BSD_1_CLAUSE = "BSD-1-Clause"
      # BSD 2-Clause "Simplified" License
      BSD_2_CLAUSE = "BSD-2-Clause"
      # BSD 2-Clause - Ian Darwin variant
      BSD_2_CLAUSE_DARWIN = "BSD-2-Clause-Darwin"
      # BSD 2-Clause - first lines requirement
      BSD_2_CLAUSE_FIRST_LINES = "BSD-2-Clause-first-lines"
      # BSD 2-Clause FreeBSD License
      BSD_2_CLAUSE_FREEBSD = "BSD-2-Clause-FreeBSD"
      # BSD 2-Clause NetBSD License
      BSD_2_CLAUSE_NETBSD = "BSD-2-Clause-NetBSD"
      # BSD-2-Clause Plus Patent License
      BSD_2_CLAUSE_PATENT = "BSD-2-Clause-Patent"
      # BSD 2-Clause with views sentence
      BSD_2_CLAUSE_VIEWS = "BSD-2-Clause-Views"
      # BSD 3-Clause "New" or "Revised" License
      BSD_3_CLAUSE = "BSD-3-Clause"
      # BSD 3-Clause acpica variant
      BSD_3_CLAUSE_ACPICA = "BSD-3-Clause-acpica"
      # BSD with attribution
      BSD_3_CLAUSE_ATTRIBUTION = "BSD-3-Clause-Attribution"
      # BSD 3-Clause Clear License
      BSD_3_CLAUSE_CLEAR = "BSD-3-Clause-Clear"
      # BSD 3-Clause Flex variant
      BSD_3_CLAUSE_FLEX = "BSD-3-Clause-flex"
      # Hewlett-Packard BSD variant license
      BSD_3_CLAUSE_HP = "BSD-3-Clause-HP"
      # Lawrence Berkeley National Labs BSD variant license
      BSD_3_CLAUSE_LBNL = "BSD-3-Clause-LBNL"
      # BSD 3-Clause Modification
      BSD_3_CLAUSE_MODIFICATION = "BSD-3-Clause-Modification"
      # BSD 3-Clause No Military License
      BSD_3_CLAUSE_NO_MILITARY_LICENSE = "BSD-3-Clause-No-Military-License"
      # BSD 3-Clause No Nuclear License
      BSD_3_CLAUSE_NO_NUCLEAR_LICENSE = "BSD-3-Clause-No-Nuclear-License"
      # BSD 3-Clause No Nuclear License 2014
      BSD_3_CLAUSE_NO_NUCLEAR_LICENSE_2014 = "BSD-3-Clause-No-Nuclear-License-2014"
      # BSD 3-Clause No Nuclear Warranty
      BSD_3_CLAUSE_NO_NUCLEAR_WARRANTY = "BSD-3-Clause-No-Nuclear-Warranty"
      # BSD 3-Clause Open MPI variant
      BSD_3_CLAUSE_OPEN_MPI = "BSD-3-Clause-Open-MPI"
      # BSD 3-Clause Sun Microsystems
      BSD_3_CLAUSE_SUN = "BSD-3-Clause-Sun"
      # BSD 4-Clause "Original" or "Old" License
      BSD_4_CLAUSE = "BSD-4-Clause"
      # BSD 4 Clause Shortened
      BSD_4_CLAUSE_SHORTENED = "BSD-4-Clause-Shortened"
      # BSD-4-Clause (University of California-Specific)
      BSD_4_CLAUSE_UC = "BSD-4-Clause-UC"
      # BSD 4.3 RENO License
      BSD_4_3RENO = "BSD-4.3RENO"
      # BSD 4.3 TAHOE License
      BSD_4_3TAHOE = "BSD-4.3TAHOE"
      # BSD Advertising Acknowledgement License
      BSD_ADVERTISING_ACKNOWLEDGEMENT = "BSD-Advertising-Acknowledgement"
      # BSD with Attribution and HPND disclaimer
      BSD_ATTRIBUTION_HPND_DISCLAIMER = "BSD-Attribution-HPND-disclaimer"
      # BSD-Inferno-Nettverk
      BSD_INFERNO_NETTVERK = "BSD-Inferno-Nettverk"
      # BSD Protection License
      BSD_PROTECTION = "BSD-Protection"
      # BSD Source Code Attribution - beginning of file variant
      BSD_SOURCE_BEGINNING_FILE = "BSD-Source-beginning-file"
      # BSD Source Code Attribution
      BSD_SOURCE_CODE = "BSD-Source-Code"
      # Systemics BSD variant license
      BSD_SYSTEMICS = "BSD-Systemics"
      # Systemics W3Works BSD variant license
      BSD_SYSTEMICS_W3WORKS = "BSD-Systemics-W3Works"
      # Boost Software License 1.0
      BSL_1_0 = "BSL-1.0"
      # Business Source License 1.1
      BUSL_1_1 = "BUSL-1.1"
      # bzip2 and libbzip2 License v1.0.5
      BZIP2_1_0_5 = "bzip2-1.0.5"
      # bzip2 and libbzip2 License v1.0.6
      BZIP2_1_0_6 = "bzip2-1.0.6"
      # Computational Use of Data Agreement v1.0
      C_UDA_1_0 = "C-UDA-1.0"
      # Cryptographic Autonomy License 1.0
      CAL_1_0 = "CAL-1.0"
      # Cryptographic Autonomy License 1.0 (Combined Work Exception)
      CAL_1_0_COMBINED_WORK_EXCEPTION = "CAL-1.0-Combined-Work-Exception"
      # Caldera License
      CALDERA = "Caldera"
      # Caldera License (without preamble)
      CALDERA_NO_PREAMBLE = "Caldera-no-preamble"
      # Catharon License
      CATHARON = "Catharon"
      # Computer Associates Trusted Open Source License 1.1
      CATOSL_1_1 = "CATOSL-1.1"
      # Creative Commons Attribution 1.0 Generic
      CC_BY_1_0 = "CC-BY-1.0"
      # Creative Commons Attribution 2.0 Generic
      CC_BY_2_0 = "CC-BY-2.0"
      # Creative Commons Attribution 2.5 Generic
      CC_BY_2_5 = "CC-BY-2.5"
      # Creative Commons Attribution 2.5 Australia
      CC_BY_2_5_AU = "CC-BY-2.5-AU"
      # Creative Commons Attribution 3.0 Unported
      CC_BY_3_0 = "CC-BY-3.0"
      # Creative Commons Attribution 3.0 Austria
      CC_BY_3_0_AT = "CC-BY-3.0-AT"
      # Creative Commons Attribution 3.0 Australia
      CC_BY_3_0_AU = "CC-BY-3.0-AU"
      # Creative Commons Attribution 3.0 Germany
      CC_BY_3_0_DE = "CC-BY-3.0-DE"
      # Creative Commons Attribution 3.0 IGO
      CC_BY_3_0_IGO = "CC-BY-3.0-IGO"
      # Creative Commons Attribution 3.0 Netherlands
      CC_BY_3_0_NL = "CC-BY-3.0-NL"
      # Creative Commons Attribution 3.0 United States
      CC_BY_3_0_US = "CC-BY-3.0-US"
      # Creative Commons Attribution 4.0 International
      CC_BY_4_0 = "CC-BY-4.0"
      # Creative Commons Attribution Non Commercial 1.0 Generic
      CC_BY_NC_1_0 = "CC-BY-NC-1.0"
      # Creative Commons Attribution Non Commercial 2.0 Generic
      CC_BY_NC_2_0 = "CC-BY-NC-2.0"
      # Creative Commons Attribution Non Commercial 2.5 Generic
      CC_BY_NC_2_5 = "CC-BY-NC-2.5"
      # Creative Commons Attribution Non Commercial 3.0 Unported
      CC_BY_NC_3_0 = "CC-BY-NC-3.0"
      # Creative Commons Attribution Non Commercial 3.0 Germany
      CC_BY_NC_3_0_DE = "CC-BY-NC-3.0-DE"
      # Creative Commons Attribution Non Commercial 4.0 International
      CC_BY_NC_4_0 = "CC-BY-NC-4.0"
      # Creative Commons Attribution Non Commercial No Derivatives 1.0 Generic
      CC_BY_NC_ND_1_0 = "CC-BY-NC-ND-1.0"
      # Creative Commons Attribution Non Commercial No Derivatives 2.0 Generic
      CC_BY_NC_ND_2_0 = "CC-BY-NC-ND-2.0"
      # Creative Commons Attribution Non Commercial No Derivatives 2.5 Generic
      CC_BY_NC_ND_2_5 = "CC-BY-NC-ND-2.5"
      # Creative Commons Attribution Non Commercial No Derivatives 3.0 Unported
      CC_BY_NC_ND_3_0 = "CC-BY-NC-ND-3.0"
      # Creative Commons Attribution Non Commercial No Derivatives 3.0 Germany
      CC_BY_NC_ND_3_0_DE = "CC-BY-NC-ND-3.0-DE"
      # Creative Commons Attribution Non Commercial No Derivatives 3.0 IGO
      CC_BY_NC_ND_3_0_IGO = "CC-BY-NC-ND-3.0-IGO"
      # Creative Commons Attribution Non Commercial No Derivatives 4.0 International
      CC_BY_NC_ND_4_0 = "CC-BY-NC-ND-4.0"
      # Creative Commons Attribution Non Commercial Share Alike 1.0 Generic
      CC_BY_NC_SA_1_0 = "CC-BY-NC-SA-1.0"
      # Creative Commons Attribution Non Commercial Share Alike 2.0 Generic
      CC_BY_NC_SA_2_0 = "CC-BY-NC-SA-2.0"
      # Creative Commons Attribution Non Commercial Share Alike 2.0 Germany
      CC_BY_NC_SA_2_0_DE = "CC-BY-NC-SA-2.0-DE"
      # Creative Commons Attribution-NonCommercial-ShareAlike 2.0 France
      CC_BY_NC_SA_2_0_FR = "CC-BY-NC-SA-2.0-FR"
      # Creative Commons Attribution Non Commercial Share Alike 2.0 England and Wales
      CC_BY_NC_SA_2_0_UK = "CC-BY-NC-SA-2.0-UK"
      # Creative Commons Attribution Non Commercial Share Alike 2.5 Generic
      CC_BY_NC_SA_2_5 = "CC-BY-NC-SA-2.5"
      # Creative Commons Attribution Non Commercial Share Alike 3.0 Unported
      CC_BY_NC_SA_3_0 = "CC-BY-NC-SA-3.0"
      # Creative Commons Attribution Non Commercial Share Alike 3.0 Germany
      CC_BY_NC_SA_3_0_DE = "CC-BY-NC-SA-3.0-DE"
      # Creative Commons Attribution Non Commercial Share Alike 3.0 IGO
      CC_BY_NC_SA_3_0_IGO = "CC-BY-NC-SA-3.0-IGO"
      # Creative Commons Attribution Non Commercial Share Alike 4.0 International
      CC_BY_NC_SA_4_0 = "CC-BY-NC-SA-4.0"
      # Creative Commons Attribution No Derivatives 1.0 Generic
      CC_BY_ND_1_0 = "CC-BY-ND-1.0"
      # Creative Commons Attribution No Derivatives 2.0 Generic
      CC_BY_ND_2_0 = "CC-BY-ND-2.0"
      # Creative Commons Attribution No Derivatives 2.5 Generic
      CC_BY_ND_2_5 = "CC-BY-ND-2.5"
      # Creative Commons Attribution No Derivatives 3.0 Unported
      CC_BY_ND_3_0 = "CC-BY-ND-3.0"
      # Creative Commons Attribution No Derivatives 3.0 Germany
      CC_BY_ND_3_0_DE = "CC-BY-ND-3.0-DE"
      # Creative Commons Attribution No Derivatives 4.0 International
      CC_BY_ND_4_0 = "CC-BY-ND-4.0"
      # Creative Commons Attribution Share Alike 1.0 Generic
      CC_BY_SA_1_0 = "CC-BY-SA-1.0"
      # Creative Commons Attribution Share Alike 2.0 Generic
      CC_BY_SA_2_0 = "CC-BY-SA-2.0"
      # Creative Commons Attribution Share Alike 2.0 England and Wales
      CC_BY_SA_2_0_UK = "CC-BY-SA-2.0-UK"
      # Creative Commons Attribution Share Alike 2.1 Japan
      CC_BY_SA_2_1_JP = "CC-BY-SA-2.1-JP"
      # Creative Commons Attribution Share Alike 2.5 Generic
      CC_BY_SA_2_5 = "CC-BY-SA-2.5"
      # Creative Commons Attribution Share Alike 3.0 Unported
      CC_BY_SA_3_0 = "CC-BY-SA-3.0"
      # Creative Commons Attribution Share Alike 3.0 Austria
      CC_BY_SA_3_0_AT = "CC-BY-SA-3.0-AT"
      # Creative Commons Attribution Share Alike 3.0 Germany
      CC_BY_SA_3_0_DE = "CC-BY-SA-3.0-DE"
      # Creative Commons Attribution-ShareAlike 3.0 IGO
      CC_BY_SA_3_0_IGO = "CC-BY-SA-3.0-IGO"
      # Creative Commons Attribution Share Alike 4.0 International
      CC_BY_SA_4_0 = "CC-BY-SA-4.0"
      # Creative Commons Public Domain Dedication and Certification
      CC_PDDC = "CC-PDDC"
      # Creative Commons Zero v1.0 Universal
      CC0_1_0 = "CC0-1.0"
      # Common Development and Distribution License 1.0
      CDDL_1_0 = "CDDL-1.0"
      # Common Development and Distribution License 1.1
      CDDL_1_1 = "CDDL-1.1"
      # Common Documentation License 1.0
      CDL_1_0 = "CDL-1.0"
      # Community Data License Agreement Permissive 1.0
      CDLA_PERMISSIVE_1_0 = "CDLA-Permissive-1.0"
      # Community Data License Agreement Permissive 2.0
      CDLA_PERMISSIVE_2_0 = "CDLA-Permissive-2.0"
      # Community Data License Agreement Sharing 1.0
      CDLA_SHARING_1_0 = "CDLA-Sharing-1.0"
      # CeCILL Free Software License Agreement v1.0
      CECILL_1_0 = "CECILL-1.0"
      # CeCILL Free Software License Agreement v1.1
      CECILL_1_1 = "CECILL-1.1"
      # CeCILL Free Software License Agreement v2.0
      CECILL_2_0 = "CECILL-2.0"
      # CeCILL Free Software License Agreement v2.1
      CECILL_2_1 = "CECILL-2.1"
      # CeCILL-B Free Software License Agreement
      CECILL_B = "CECILL-B"
      # CeCILL-C Free Software License Agreement
      CECILL_C = "CECILL-C"
      # CERN Open Hardware Licence v1.1
      CERN_OHL_1_1 = "CERN-OHL-1.1"
      # CERN Open Hardware Licence v1.2
      CERN_OHL_1_2 = "CERN-OHL-1.2"
      # CERN Open Hardware Licence Version 2 - Permissive
      CERN_OHL_P_2_0 = "CERN-OHL-P-2.0"
      # CERN Open Hardware Licence Version 2 - Strongly Reciprocal
      CERN_OHL_S_2_0 = "CERN-OHL-S-2.0"
      # CERN Open Hardware Licence Version 2 - Weakly Reciprocal
      CERN_OHL_W_2_0 = "CERN-OHL-W-2.0"
      # CFITSIO License
      CFITSIO = "CFITSIO"
      # check-cvs License
      CHECK_CVS = "check-cvs"
      # Checkmk License
      CHECKMK = "checkmk"
      # Clarified Artistic License
      CLARTISTIC = "ClArtistic"
      # Clips License
      CLIPS = "Clips"
      # CMU Mach License
      CMU_MACH = "CMU-Mach"
      # CMU    Mach - no notices-in-documentation variant
      CMU_MACH_NODOC = "CMU-Mach-nodoc"
      # CNRI Jython License
      CNRI_JYTHON = "CNRI-Jython"
      # CNRI Python License
      CNRI_PYTHON = "CNRI-Python"
      # CNRI Python Open Source GPL Compatible License Agreement
      CNRI_PYTHON_GPL_COMPATIBLE = "CNRI-Python-GPL-Compatible"
      # Copyfree Open Innovation License
      COIL_1_0 = "COIL-1.0"
      # Community Specification License 1.0
      COMMUNITY_SPEC_1_0 = "Community-Spec-1.0"
      # Condor Public License v1.1
      CONDOR_1_1 = "Condor-1.1"
      # copyleft-next 0.3.0
      COPYLEFT_NEXT_0_3_0 = "copyleft-next-0.3.0"
      # copyleft-next 0.3.1
      COPYLEFT_NEXT_0_3_1 = "copyleft-next-0.3.1"
      # Cornell Lossless JPEG License
      CORNELL_LOSSLESS_JPEG = "Cornell-Lossless-JPEG"
      # Common Public Attribution License 1.0
      CPAL_1_0 = "CPAL-1.0"
      # Common Public License 1.0
      CPL_1_0 = "CPL-1.0"
      # Code Project Open License 1.02
      CPOL_1_02 = "CPOL-1.02"
      # Cronyx License
      CRONYX = "Cronyx"
      # Crossword License
      CROSSWORD = "Crossword"
      # CrystalStacker License
      CRYSTALSTACKER = "CrystalStacker"
      # CUA Office Public License v1.0
      CUA_OPL_1_0 = "CUA-OPL-1.0"
      # Cube License
      CUBE = "Cube"
      # curl License
      CURL = "curl"
      # Common Vulnerability Enumeration ToU License
      CVE_TOU = "cve-tou"
      # Deutsche Freie Software Lizenz
      D_FSL_1_0 = "D-FSL-1.0"
      # DEC 3-Clause License
      DEC_3_CLAUSE = "DEC-3-Clause"
      # diffmark license
      DIFFMARK = "diffmark"
      # Data licence Germany – attribution – version 2.0
      DL_DE_BY_2_0 = "DL-DE-BY-2.0"
      # Data licence Germany – zero – version 2.0
      DL_DE_ZERO_2_0 = "DL-DE-ZERO-2.0"
      # DOC License
      DOC = "DOC"
      # DocBook Schema License
      DOCBOOK_SCHEMA = "DocBook-Schema"
      # DocBook Stylesheet License
      DOCBOOK_STYLESHEET = "DocBook-Stylesheet"
      # DocBook XML License
      DOCBOOK_XML = "DocBook-XML"
      # Dotseqn License
      DOTSEQN = "Dotseqn"
      # Detection Rule License 1.0
      DRL_1_0 = "DRL-1.0"
      # Detection Rule License 1.1
      DRL_1_1 = "DRL-1.1"
      # DSDP License
      DSDP = "DSDP"
      # David M. Gay dtoa License
      DTOA = "dtoa"
      # dvipdfm License
      DVIPDFM = "dvipdfm"
      # Educational Community License v1.0
      ECL_1_0 = "ECL-1.0"
      # Educational Community License v2.0
      ECL_2_0 = "ECL-2.0"
      # eCos license version 2.0
      ECOS_2_0 = "eCos-2.0"
      # Eiffel Forum License v1.0
      EFL_1_0 = "EFL-1.0"
      # Eiffel Forum License v2.0
      EFL_2_0 = "EFL-2.0"
      # eGenix.com Public License 1.1.0
      EGENIX = "eGenix"
      # Elastic License 2.0
      ELASTIC_2_0 = "Elastic-2.0"
      # Entessa Public License v1.0
      ENTESSA = "Entessa"
      # EPICS Open License
      EPICS = "EPICS"
      # Eclipse Public License 1.0
      EPL_1_0 = "EPL-1.0"
      # Eclipse Public License 2.0
      EPL_2_0 = "EPL-2.0"
      # Erlang Public License v1.1
      ERLPL_1_1 = "ErlPL-1.1"
      # Etalab Open License 2.0
      ETALAB_2_0 = "etalab-2.0"
      # EU DataGrid Software License
      EUDATAGRID = "EUDatagrid"
      # European Union Public License 1.0
      EUPL_1_0 = "EUPL-1.0"
      # European Union Public License 1.1
      EUPL_1_1 = "EUPL-1.1"
      # European Union Public License 1.2
      EUPL_1_2 = "EUPL-1.2"
      # Eurosym License
      EUROSYM = "Eurosym"
      # Fair License
      FAIR = "Fair"
      # Fuzzy Bitmap License
      FBM = "FBM"
      # Fraunhofer FDK AAC Codec Library
      FDK_AAC = "FDK-AAC"
      # Ferguson Twofish License
      FERGUSON_TWOFISH = "Ferguson-Twofish"
      # Frameworx Open License 1.0
      FRAMEWORX_1_0 = "Frameworx-1.0"
      # FreeBSD Documentation License
      FREEBSD_DOC = "FreeBSD-DOC"
      # FreeImage Public License v1.0
      FREEIMAGE = "FreeImage"
      # FSF All Permissive License
      FSFAP = "FSFAP"
      # FSF All Permissive License (without Warranty)
      FSFAP_NO_WARRANTY_DISCLAIMER = "FSFAP-no-warranty-disclaimer"
      # FSF Unlimited License
      FSFUL = "FSFUL"
      # FSF Unlimited License (with License Retention)
      FSFULLR = "FSFULLR"
      # FSF Unlimited License (With License Retention and Warranty Disclaimer)
      FSFULLRWD = "FSFULLRWD"
      # Freetype Project License
      FTL = "FTL"
      # Furuseth License
      FURUSETH = "Furuseth"
      # fwlw License
      FWLW = "fwlw"
      # Gnome GCR Documentation License
      GCR_DOCS = "GCR-docs"
      # GD License
      GD = "GD"
      # GNU Free Documentation License v1.1
      GFDL_1_1 = "GFDL-1.1"
      # GNU Free Documentation License v1.1 only - invariants
      GFDL_1_1_INVARIANTS_ONLY = "GFDL-1.1-invariants-only"
      # GNU Free Documentation License v1.1 or later - invariants
      GFDL_1_1_INVARIANTS_OR_LATER = "GFDL-1.1-invariants-or-later"
      # GNU Free Documentation License v1.1 only - no invariants
      GFDL_1_1_NO_INVARIANTS_ONLY = "GFDL-1.1-no-invariants-only"
      # GNU Free Documentation License v1.1 or later - no invariants
      GFDL_1_1_NO_INVARIANTS_OR_LATER = "GFDL-1.1-no-invariants-or-later"
      # GNU Free Documentation License v1.1 only
      GFDL_1_1_ONLY = "GFDL-1.1-only"
      # GNU Free Documentation License v1.1 or later
      GFDL_1_1_OR_LATER = "GFDL-1.1-or-later"
      # GNU Free Documentation License v1.2
      GFDL_1_2 = "GFDL-1.2"
      # GNU Free Documentation License v1.2 only - invariants
      GFDL_1_2_INVARIANTS_ONLY = "GFDL-1.2-invariants-only"
      # GNU Free Documentation License v1.2 or later - invariants
      GFDL_1_2_INVARIANTS_OR_LATER = "GFDL-1.2-invariants-or-later"
      # GNU Free Documentation License v1.2 only - no invariants
      GFDL_1_2_NO_INVARIANTS_ONLY = "GFDL-1.2-no-invariants-only"
      # GNU Free Documentation License v1.2 or later - no invariants
      GFDL_1_2_NO_INVARIANTS_OR_LATER = "GFDL-1.2-no-invariants-or-later"
      # GNU Free Documentation License v1.2 only
      GFDL_1_2_ONLY = "GFDL-1.2-only"
      # GNU Free Documentation License v1.2 or later
      GFDL_1_2_OR_LATER = "GFDL-1.2-or-later"
      # GNU Free Documentation License v1.3
      GFDL_1_3 = "GFDL-1.3"
      # GNU Free Documentation License v1.3 only - invariants
      GFDL_1_3_INVARIANTS_ONLY = "GFDL-1.3-invariants-only"
      # GNU Free Documentation License v1.3 or later - invariants
      GFDL_1_3_INVARIANTS_OR_LATER = "GFDL-1.3-invariants-or-later"
      # GNU Free Documentation License v1.3 only - no invariants
      GFDL_1_3_NO_INVARIANTS_ONLY = "GFDL-1.3-no-invariants-only"
      # GNU Free Documentation License v1.3 or later - no invariants
      GFDL_1_3_NO_INVARIANTS_OR_LATER = "GFDL-1.3-no-invariants-or-later"
      # GNU Free Documentation License v1.3 only
      GFDL_1_3_ONLY = "GFDL-1.3-only"
      # GNU Free Documentation License v1.3 or later
      GFDL_1_3_OR_LATER = "GFDL-1.3-or-later"
      # Giftware License
      GIFTWARE = "Giftware"
      # GL2PS License
      GL2PS = "GL2PS"
      # 3dfx Glide License
      GLIDE = "Glide"
      # Glulxe License
      GLULXE = "Glulxe"
      # Good Luck With That Public License
      GLWTPL = "GLWTPL"
      # gnuplot License
      GNUPLOT = "gnuplot"
      # GNU General Public License v1.0 only
      GPL_1_0 = "GPL-1.0"
      # GNU General Public License v1.0 or later
      GPL_1_0_ = "GPL-1.0+"
      # GNU General Public License v1.0 only
      GPL_1_0_ONLY = "GPL-1.0-only"
      # GNU General Public License v1.0 or later
      GPL_1_0_OR_LATER = "GPL-1.0-or-later"
      # GNU General Public License v2.0 only
      GPL_2_0 = "GPL-2.0"
      # GNU General Public License v2.0 or later
      GPL_2_0_ = "GPL-2.0+"
      # GNU General Public License v2.0 only
      GPL_2_0_ONLY = "GPL-2.0-only"
      # GNU General Public License v2.0 or later
      GPL_2_0_OR_LATER = "GPL-2.0-or-later"
      # GNU General Public License v2.0 w/Autoconf exception
      GPL_2_0_WITH_AUTOCONF_EXCEPTION = "GPL-2.0-with-autoconf-exception"
      # GNU General Public License v2.0 w/Bison exception
      GPL_2_0_WITH_BISON_EXCEPTION = "GPL-2.0-with-bison-exception"
      # GNU General Public License v2.0 w/Classpath exception
      GPL_2_0_WITH_CLASSPATH_EXCEPTION = "GPL-2.0-with-classpath-exception"
      # GNU General Public License v2.0 w/Font exception
      GPL_2_0_WITH_FONT_EXCEPTION = "GPL-2.0-with-font-exception"
      # GNU General Public License v2.0 w/GCC Runtime Library exception
      GPL_2_0_WITH_GCC_EXCEPTION = "GPL-2.0-with-GCC-exception"
      # GNU General Public License v3.0 only
      GPL_3_0 = "GPL-3.0"
      # GNU General Public License v3.0 or later
      GPL_3_0_ = "GPL-3.0+"
      # GNU General Public License v3.0 only
      GPL_3_0_ONLY = "GPL-3.0-only"
      # GNU General Public License v3.0 or later
      GPL_3_0_OR_LATER = "GPL-3.0-or-later"
      # GNU General Public License v3.0 w/Autoconf exception
      GPL_3_0_WITH_AUTOCONF_EXCEPTION = "GPL-3.0-with-autoconf-exception"
      # GNU General Public License v3.0 w/GCC Runtime Library exception
      GPL_3_0_WITH_GCC_EXCEPTION = "GPL-3.0-with-GCC-exception"
      # Graphics Gems License
      GRAPHICS_GEMS = "Graphics-Gems"
      # gSOAP Public License v1.3b
      GSOAP_1_3B = "gSOAP-1.3b"
      # gtkbook License
      GTKBOOK = "gtkbook"
      # Gutmann License
      GUTMANN = "Gutmann"
      # Haskell Language Report License
      HASKELLREPORT = "HaskellReport"
      # hdparm License
      HDPARM = "hdparm"
      # HIDAPI License
      HIDAPI = "HIDAPI"
      # Hippocratic License 2.1
      HIPPOCRATIC_2_1 = "Hippocratic-2.1"
      # Hewlett-Packard 1986 License
      HP_1986 = "HP-1986"
      # Hewlett-Packard 1989 License
      HP_1989 = "HP-1989"
      # Historical Permission Notice and Disclaimer
      HPND = "HPND"
      # Historical Permission Notice and Disclaimer - DEC variant
      HPND_DEC = "HPND-DEC"
      # Historical Permission Notice and Disclaimer - documentation variant
      HPND_DOC = "HPND-doc"
      # Historical Permission Notice and Disclaimer - documentation sell variant
      HPND_DOC_SELL = "HPND-doc-sell"
      # HPND with US Government export control warning
      HPND_EXPORT_US = "HPND-export-US"
      # HPND with US Government export control warning and acknowledgment
      HPND_EXPORT_US_ACKNOWLEDGEMENT = "HPND-export-US-acknowledgement"
      # HPND with US Government export control warning and modification rqmt
      HPND_EXPORT_US_MODIFY = "HPND-export-US-modify"
      # HPND with US Government export control and 2 disclaimers
      HPND_EXPORT2_US = "HPND-export2-US"
      # Historical Permission Notice and Disclaimer - Fenneberg-Livingston variant
      HPND_FENNEBERG_LIVINGSTON = "HPND-Fenneberg-Livingston"
      # Historical Permission Notice and Disclaimer    - INRIA-IMAG variant
      HPND_INRIA_IMAG = "HPND-INRIA-IMAG"
      # Historical Permission Notice and Disclaimer - Intel variant
      HPND_INTEL = "HPND-Intel"
      # Historical Permission Notice and Disclaimer - Kevlin Henney variant
      HPND_KEVLIN_HENNEY = "HPND-Kevlin-Henney"
      # Historical Permission Notice and Disclaimer - Markus Kuhn variant
      HPND_MARKUS_KUHN = "HPND-Markus-Kuhn"
      # Historical Permission Notice and Disclaimer - merchantability variant
      HPND_MERCHANTABILITY_VARIANT = "HPND-merchantability-variant"
      # Historical Permission Notice and Disclaimer with MIT disclaimer
      HPND_MIT_DISCLAIMER = "HPND-MIT-disclaimer"
      # Historical Permission Notice and Disclaimer - Netrek variant
      HPND_NETREK = "HPND-Netrek"
      # Historical Permission Notice and Disclaimer - Pbmplus variant
      HPND_PBMPLUS = "HPND-Pbmplus"
      # Historical Permission Notice and Disclaimer - sell xserver variant with MIT disclaimer
      HPND_SELL_MIT_DISCLAIMER_XSERVER = "HPND-sell-MIT-disclaimer-xserver"
      # Historical Permission Notice and Disclaimer - sell regexpr variant
      HPND_SELL_REGEXPR = "HPND-sell-regexpr"
      # Historical Permission Notice and Disclaimer - sell variant
      HPND_SELL_VARIANT = "HPND-sell-variant"
      # HPND sell variant with MIT disclaimer
      HPND_SELL_VARIANT_MIT_DISCLAIMER = "HPND-sell-variant-MIT-disclaimer"
      # HPND sell variant with MIT disclaimer - reverse
      HPND_SELL_VARIANT_MIT_DISCLAIMER_REV = "HPND-sell-variant-MIT-disclaimer-rev"
      # Historical Permission Notice and Disclaimer - University of California variant
      HPND_UC = "HPND-UC"
      # Historical Permission Notice and Disclaimer - University of California, US export warning
      HPND_UC_EXPORT_US = "HPND-UC-export-US"
      # HTML Tidy License
      HTMLTIDY = "HTMLTIDY"
      # IBM PowerPC Initialization and Boot Software
      IBM_PIBS = "IBM-pibs"
      # ICU License
      ICU = "ICU"
      # IEC    Code Components End-user licence agreement
      IEC_CODE_COMPONENTS_EULA = "IEC-Code-Components-EULA"
      # Independent JPEG Group License
      IJG = "IJG"
      # Independent JPEG Group License - short
      IJG_SHORT = "IJG-short"
      # ImageMagick License
      IMAGEMAGICK = "ImageMagick"
      # iMatix Standard Function Library Agreement
      IMATIX = "iMatix"
      # Imlib2 License
      IMLIB2 = "Imlib2"
      # Info-ZIP License
      INFO_ZIP = "Info-ZIP"
      # Inner Net License v2.0
      INNER_NET_2_0 = "Inner-Net-2.0"
      # Intel Open Source License
      INTEL = "Intel"
      # Intel ACPI Software License Agreement
      INTEL_ACPI = "Intel-ACPI"
      # Interbase Public License v1.0
      INTERBASE_1_0 = "Interbase-1.0"
      # IPA Font License
      IPA = "IPA"
      # IBM Public License v1.0
      IPL_1_0 = "IPL-1.0"
      # ISC License
      ISC = "ISC"
      # ISC Veillard variant
      ISC_VEILLARD = "ISC-Veillard"
      # Jam License
      JAM = "Jam"
      # JasPer License
      JASPER_2_0 = "JasPer-2.0"
      # JPL Image Use Policy
      JPL_IMAGE = "JPL-image"
      # Japan Network Information Center License
      JPNIC = "JPNIC"
      # JSON License
      JSON = "JSON"
      # Kastrup License
      KASTRUP = "Kastrup"
      # Kazlib License
      KAZLIB = "Kazlib"
      # Knuth CTAN License
      KNUTH_CTAN = "Knuth-CTAN"
      # Licence Art Libre 1.2
      LAL_1_2 = "LAL-1.2"
      # Licence Art Libre 1.3
      LAL_1_3 = "LAL-1.3"
      # Latex2e License
      LATEX2E = "Latex2e"
      # Latex2e with translated notice permission
      LATEX2E_TRANSLATED_NOTICE = "Latex2e-translated-notice"
      # Leptonica License
      LEPTONICA = "Leptonica"
      # GNU Library General Public License v2 only
      LGPL_2_0 = "LGPL-2.0"
      # GNU Library General Public License v2 or later
      LGPL_2_0_ = "LGPL-2.0+"
      # GNU Library General Public License v2 only
      LGPL_2_0_ONLY = "LGPL-2.0-only"
      # GNU Library General Public License v2 or later
      LGPL_2_0_OR_LATER = "LGPL-2.0-or-later"
      # GNU Lesser General Public License v2.1 only
      LGPL_2_1 = "LGPL-2.1"
      # GNU Lesser General Public License v2.1 or later
      LGPL_2_1_ = "LGPL-2.1+"
      # GNU Lesser General Public License v2.1 only
      LGPL_2_1_ONLY = "LGPL-2.1-only"
      # GNU Lesser General Public License v2.1 or later
      LGPL_2_1_OR_LATER = "LGPL-2.1-or-later"
      # GNU Lesser General Public License v3.0 only
      LGPL_3_0 = "LGPL-3.0"
      # GNU Lesser General Public License v3.0 or later
      LGPL_3_0_ = "LGPL-3.0+"
      # GNU Lesser General Public License v3.0 only
      LGPL_3_0_ONLY = "LGPL-3.0-only"
      # GNU Lesser General Public License v3.0 or later
      LGPL_3_0_OR_LATER = "LGPL-3.0-or-later"
      # Lesser General Public License For Linguistic Resources
      LGPLLR = "LGPLLR"
      # libpng License
      LIBPNG = "Libpng"
      # PNG Reference Library version 2
      LIBPNG_2_0 = "libpng-2.0"
      # libselinux public domain notice
      LIBSELINUX_1_0 = "libselinux-1.0"
      # libtiff License
      LIBTIFF = "libtiff"
      # libutil David Nugent License
      LIBUTIL_DAVID_NUGENT = "libutil-David-Nugent"
      # Licence Libre du Québec – Permissive version 1.1
      LILIQ_P_1_1 = "LiLiQ-P-1.1"
      # Licence Libre du Québec – Réciprocité version 1.1
      LILIQ_R_1_1 = "LiLiQ-R-1.1"
      # Licence Libre du Québec – Réciprocité forte version 1.1
      LILIQ_RPLUS_1_1 = "LiLiQ-Rplus-1.1"
      # Linux man-pages - 1 paragraph
      LINUX_MAN_PAGES_1_PARA = "Linux-man-pages-1-para"
      # Linux man-pages Copyleft
      LINUX_MAN_PAGES_COPYLEFT = "Linux-man-pages-copyleft"
      # Linux man-pages Copyleft - 2 paragraphs
      LINUX_MAN_PAGES_COPYLEFT_2_PARA = "Linux-man-pages-copyleft-2-para"
      # Linux man-pages Copyleft Variant
      LINUX_MAN_PAGES_COPYLEFT_VAR = "Linux-man-pages-copyleft-var"
      # Linux Kernel Variant of OpenIB.org license
      LINUX_OPENIB = "Linux-OpenIB"
      # Common Lisp LOOP License
      LOOP = "LOOP"
      # LPD Documentation License
      LPD_DOCUMENT = "LPD-document"
      # Lucent Public License Version 1.0
      LPL_1_0 = "LPL-1.0"
      # Lucent Public License v1.02
      LPL_1_02 = "LPL-1.02"
      # LaTeX Project Public License v1.0
      LPPL_1_0 = "LPPL-1.0"
      # LaTeX Project Public License v1.1
      LPPL_1_1 = "LPPL-1.1"
      # LaTeX Project Public License v1.2
      LPPL_1_2 = "LPPL-1.2"
      # LaTeX Project Public License v1.3a
      LPPL_1_3A = "LPPL-1.3a"
      # LaTeX Project Public License v1.3c
      LPPL_1_3C = "LPPL-1.3c"
      # lsof License
      LSOF = "lsof"
      # Lucida Bitmap Fonts License
      LUCIDA_BITMAP_FONTS = "Lucida-Bitmap-Fonts"
      # LZMA SDK License (versions 9.11 to 9.20)
      LZMA_SDK_9_11_TO_9_20 = "LZMA-SDK-9.11-to-9.20"
      # LZMA SDK License (versions 9.22 and beyond)
      LZMA_SDK_9_22 = "LZMA-SDK-9.22"
      # Mackerras 3-Clause License
      MACKERRAS_3_CLAUSE = "Mackerras-3-Clause"
      # Mackerras 3-Clause - acknowledgment variant
      MACKERRAS_3_CLAUSE_ACKNOWLEDGMENT = "Mackerras-3-Clause-acknowledgment"
      # magaz License
      MAGAZ = "magaz"
      # mailprio License
      MAILPRIO = "mailprio"
      # MakeIndex License
      MAKEINDEX = "MakeIndex"
      # Martin Birgmeier License
      MARTIN_BIRGMEIER = "Martin-Birgmeier"
      # McPhee Slideshow License
      MCPHEE_SLIDESHOW = "McPhee-slideshow"
      # metamail License
      METAMAIL = "metamail"
      # Minpack License
      MINPACK = "Minpack"
      # The MirOS Licence
      MIROS = "MirOS"
      # MIT License
      MIT = "MIT"
      # MIT No Attribution
      MIT_0 = "MIT-0"
      # Enlightenment License (e16)
      MIT_ADVERTISING = "MIT-advertising"
      # MIT Click License
      MIT_CLICK = "MIT-Click"
      # CMU License
      MIT_CMU = "MIT-CMU"
      # enna License
      MIT_ENNA = "MIT-enna"
      # feh License
      MIT_FEH = "MIT-feh"
      # MIT Festival Variant
      MIT_FESTIVAL = "MIT-Festival"
      # MIT Khronos - old variant
      MIT_KHRONOS_OLD = "MIT-Khronos-old"
      # MIT License Modern Variant
      MIT_MODERN_VARIANT = "MIT-Modern-Variant"
      # MIT Open Group variant
      MIT_OPEN_GROUP = "MIT-open-group"
      # MIT testregex Variant
      MIT_TESTREGEX = "MIT-testregex"
      # MIT Tom Wu Variant
      MIT_WU = "MIT-Wu"
      # MIT +no-false-attribs license
      MITNFA = "MITNFA"
      # MMIXware License
      MMIXWARE = "MMIXware"
      # Motosoto License
      MOTOSOTO = "Motosoto"
      # MPEG Software Simulation
      MPEG_SSG = "MPEG-SSG"
      # mpi Permissive License
      MPI_PERMISSIVE = "mpi-permissive"
      # mpich2 License
      MPICH2 = "mpich2"
      # Mozilla Public License 1.0
      MPL_1_0 = "MPL-1.0"
      # Mozilla Public License 1.1
      MPL_1_1 = "MPL-1.1"
      # Mozilla Public License 2.0
      MPL_2_0 = "MPL-2.0"
      # Mozilla Public License 2.0 (no copyleft exception)
      MPL_2_0_NO_COPYLEFT_EXCEPTION = "MPL-2.0-no-copyleft-exception"
      # mplus Font License
      MPLUS = "mplus"
      # Microsoft Limited Public License
      MS_LPL = "MS-LPL"
      # Microsoft Public License
      MS_PL = "MS-PL"
      # Microsoft Reciprocal License
      MS_RL = "MS-RL"
      # Matrix Template Library License
      MTLL = "MTLL"
      # Mulan Permissive Software License, Version 1
      MULANPSL_1_0 = "MulanPSL-1.0"
      # Mulan Permissive Software License, Version 2
      MULANPSL_2_0 = "MulanPSL-2.0"
      # Multics License
      MULTICS = "Multics"
      # Mup License
      MUP = "Mup"
      # Nara Institute of Science and Technology License (2003)
      NAIST_2003 = "NAIST-2003"
      # NASA Open Source Agreement 1.3
      NASA_1_3 = "NASA-1.3"
      # Naumen Public License
      NAUMEN = "Naumen"
      # Net Boolean Public License v1
      NBPL_1_0 = "NBPL-1.0"
      # NCBI Public Domain Notice
      NCBI_PD = "NCBI-PD"
      # Non-Commercial Government Licence
      NCGL_UK_2_0 = "NCGL-UK-2.0"
      # NCL Source Code License
      NCL = "NCL"
      # University of Illinois/NCSA Open Source License
      NCSA = "NCSA"
      # Net-SNMP License
      NET_SNMP = "Net-SNMP"
      # NetCDF license
      NETCDF = "NetCDF"
      # Newsletr License
      NEWSLETR = "Newsletr"
      # Nethack General Public License
      NGPL = "NGPL"
      # NICTA Public Software License, Version 1.0
      NICTA_1_0 = "NICTA-1.0"
      # NIST Public Domain Notice
      NIST_PD = "NIST-PD"
      # NIST Public Domain Notice with license fallback
      NIST_PD_FALLBACK = "NIST-PD-fallback"
      # NIST Software License
      NIST_SOFTWARE = "NIST-Software"
      # Norwegian Licence for Open Government Data (NLOD) 1.0
      NLOD_1_0 = "NLOD-1.0"
      # Norwegian Licence for Open Government Data (NLOD) 2.0
      NLOD_2_0 = "NLOD-2.0"
      # No Limit Public License
      NLPL = "NLPL"
      # Nokia Open Source License
      NOKIA = "Nokia"
      # Netizen Open Source License
      NOSL = "NOSL"
      # Noweb License
      NOWEB = "Noweb"
      # Netscape Public License v1.0
      NPL_1_0 = "NPL-1.0"
      # Netscape Public License v1.1
      NPL_1_1 = "NPL-1.1"
      # Non-Profit Open Software License 3.0
      NPOSL_3_0 = "NPOSL-3.0"
      # NRL License
      NRL = "NRL"
      # NTP License
      NTP = "NTP"
      # NTP No Attribution
      NTP_0 = "NTP-0"
      # Nunit License
      NUNIT = "Nunit"
      # Open Use of Data Agreement v1.0
      O_UDA_1_0 = "O-UDA-1.0"
      # OAR License
      OAR = "OAR"
      # Open CASCADE Technology Public License
      OCCT_PL = "OCCT-PL"
      # OCLC Research Public License 2.0
      OCLC_2_0 = "OCLC-2.0"
      # Open Data Commons Open Database License v1.0
      ODBL_1_0 = "ODbL-1.0"
      # Open Data Commons Attribution License v1.0
      ODC_BY_1_0 = "ODC-By-1.0"
      # OFFIS License
      OFFIS = "OFFIS"
      # SIL Open Font License 1.0
      OFL_1_0 = "OFL-1.0"
      # SIL Open Font License 1.0 with no Reserved Font Name
      OFL_1_0_NO_RFN = "OFL-1.0-no-RFN"
      # SIL Open Font License 1.0 with Reserved Font Name
      OFL_1_0_RFN = "OFL-1.0-RFN"
      # SIL Open Font License 1.1
      OFL_1_1 = "OFL-1.1"
      # SIL Open Font License 1.1 with no Reserved Font Name
      OFL_1_1_NO_RFN = "OFL-1.1-no-RFN"
      # SIL Open Font License 1.1 with Reserved Font Name
      OFL_1_1_RFN = "OFL-1.1-RFN"
      # OGC Software License, Version 1.0
      OGC_1_0 = "OGC-1.0"
      # Taiwan Open Government Data License, version 1.0
      OGDL_TAIWAN_1_0 = "OGDL-Taiwan-1.0"
      # Open Government Licence - Canada
      OGL_CANADA_2_0 = "OGL-Canada-2.0"
      # Open Government Licence v1.0
      OGL_UK_1_0 = "OGL-UK-1.0"
      # Open Government Licence v2.0
      OGL_UK_2_0 = "OGL-UK-2.0"
      # Open Government Licence v3.0
      OGL_UK_3_0 = "OGL-UK-3.0"
      # Open Group Test Suite License
      OGTSL = "OGTSL"
      # Open LDAP Public License v1.1
      OLDAP_1_1 = "OLDAP-1.1"
      # Open LDAP Public License v1.2
      OLDAP_1_2 = "OLDAP-1.2"
      # Open LDAP Public License v1.3
      OLDAP_1_3 = "OLDAP-1.3"
      # Open LDAP Public License v1.4
      OLDAP_1_4 = "OLDAP-1.4"
      # Open LDAP Public License v2.0 (or possibly 2.0A and 2.0B)
      OLDAP_2_0 = "OLDAP-2.0"
      # Open LDAP Public License v2.0.1
      OLDAP_2_0_1 = "OLDAP-2.0.1"
      # Open LDAP Public License v2.1
      OLDAP_2_1 = "OLDAP-2.1"
      # Open LDAP Public License v2.2
      OLDAP_2_2 = "OLDAP-2.2"
      # Open LDAP Public License v2.2.1
      OLDAP_2_2_1 = "OLDAP-2.2.1"
      # Open LDAP Public License 2.2.2
      OLDAP_2_2_2 = "OLDAP-2.2.2"
      # Open LDAP Public License v2.3
      OLDAP_2_3 = "OLDAP-2.3"
      # Open LDAP Public License v2.4
      OLDAP_2_4 = "OLDAP-2.4"
      # Open LDAP Public License v2.5
      OLDAP_2_5 = "OLDAP-2.5"
      # Open LDAP Public License v2.6
      OLDAP_2_6 = "OLDAP-2.6"
      # Open LDAP Public License v2.7
      OLDAP_2_7 = "OLDAP-2.7"
      # Open LDAP Public License v2.8
      OLDAP_2_8 = "OLDAP-2.8"
      # Open Logistics Foundation License Version 1.3
      OLFL_1_3 = "OLFL-1.3"
      # Open Market License
      OML = "OML"
      # OpenPBS v2.3 Software License
      OPENPBS_2_3 = "OpenPBS-2.3"
      # OpenSSL License
      OPENSSL = "OpenSSL"
      # OpenSSL License - standalone
      OPENSSL_STANDALONE = "OpenSSL-standalone"
      # OpenVision License
      OPENVISION = "OpenVision"
      # Open Public License v1.0
      OPL_1_0 = "OPL-1.0"
      # United    Kingdom Open Parliament Licence v3.0
      OPL_UK_3_0 = "OPL-UK-3.0"
      # Open Publication License v1.0
      OPUBL_1_0 = "OPUBL-1.0"
      # OSET Public License version 2.1
      OSET_PL_2_1 = "OSET-PL-2.1"
      # Open Software License 1.0
      OSL_1_0 = "OSL-1.0"
      # Open Software License 1.1
      OSL_1_1 = "OSL-1.1"
      # Open Software License 2.0
      OSL_2_0 = "OSL-2.0"
      # Open Software License 2.1
      OSL_2_1 = "OSL-2.1"
      # Open Software License 3.0
      OSL_3_0 = "OSL-3.0"
      # PADL License
      PADL = "PADL"
      # The Parity Public License 6.0.0
      PARITY_6_0_0 = "Parity-6.0.0"
      # The Parity Public License 7.0.0
      PARITY_7_0_0 = "Parity-7.0.0"
      # Open Data Commons Public Domain Dedication & License 1.0
      PDDL_1_0 = "PDDL-1.0"
      # PHP License v3.0
      PHP_3_0 = "PHP-3.0"
      # PHP License v3.01
      PHP_3_01 = "PHP-3.01"
      # Pixar License
      PIXAR = "Pixar"
      # pkgconf License
      PKGCONF = "pkgconf"
      # Plexus Classworlds License
      PLEXUS = "Plexus"
      # pnmstitch License
      PNMSTITCH = "pnmstitch"
      # PolyForm Noncommercial License 1.0.0
      POLYFORM_NONCOMMERCIAL_1_0_0 = "PolyForm-Noncommercial-1.0.0"
      # PolyForm Small Business License 1.0.0
      POLYFORM_SMALL_BUSINESS_1_0_0 = "PolyForm-Small-Business-1.0.0"
      # PostgreSQL License
      POSTGRESQL = "PostgreSQL"
      # Peer Production License
      PPL = "PPL"
      # Python Software Foundation License 2.0
      PSF_2_0 = "PSF-2.0"
      # psfrag License
      PSFRAG = "psfrag"
      # psutils License
      PSUTILS = "psutils"
      # Python License 2.0
      PYTHON_2_0 = "Python-2.0"
      # Python License 2.0.1
      PYTHON_2_0_1 = "Python-2.0.1"
      # Python ldap License
      PYTHON_LDAP = "python-ldap"
      # Qhull License
      QHULL = "Qhull"
      # Q Public License 1.0
      QPL_1_0 = "QPL-1.0"
      # Q Public License 1.0 - INRIA 2004 variant
      QPL_1_0_INRIA_2004 = "QPL-1.0-INRIA-2004"
      # radvd License
      RADVD = "radvd"
      # Rdisc License
      RDISC = "Rdisc"
      # Red Hat eCos Public License v1.1
      RHECOS_1_1 = "RHeCos-1.1"
      # Reciprocal Public License 1.1
      RPL_1_1 = "RPL-1.1"
      # Reciprocal Public License 1.5
      RPL_1_5 = "RPL-1.5"
      # RealNetworks Public Source License v1.0
      RPSL_1_0 = "RPSL-1.0"
      # RSA Message-Digest License
      RSA_MD = "RSA-MD"
      # Ricoh Source Code Public License
      RSCPL = "RSCPL"
      # Ruby License
      RUBY = "Ruby"
      # Ruby pty extension license
      RUBY_PTY = "Ruby-pty"
      # Sax Public Domain Notice
      SAX_PD = "SAX-PD"
      # Sax Public Domain Notice 2.0
      SAX_PD_2_0 = "SAX-PD-2.0"
      # Saxpath License
      SAXPATH = "Saxpath"
      # SCEA Shared Source License
      SCEA = "SCEA"
      # Scheme Language Report License
      SCHEMEREPORT = "SchemeReport"
      # Sendmail License
      SENDMAIL = "Sendmail"
      # Sendmail License 8.23
      SENDMAIL_8_23 = "Sendmail-8.23"
      # SGI Free Software License B v1.0
      SGI_B_1_0 = "SGI-B-1.0"
      # SGI Free Software License B v1.1
      SGI_B_1_1 = "SGI-B-1.1"
      # SGI Free Software License B v2.0
      SGI_B_2_0 = "SGI-B-2.0"
      # SGI OpenGL License
      SGI_OPENGL = "SGI-OpenGL"
      # SGP4 Permission Notice
      SGP4 = "SGP4"
      # Solderpad Hardware License v0.5
      SHL_0_5 = "SHL-0.5"
      # Solderpad Hardware License, Version 0.51
      SHL_0_51 = "SHL-0.51"
      # Simple Public License 2.0
      SIMPL_2_0 = "SimPL-2.0"
      # Sun Industry Standards Source License v1.1
      SISSL = "SISSL"
      # Sun Industry Standards Source License v1.2
      SISSL_1_2 = "SISSL-1.2"
      # SL License
      SL = "SL"
      # Sleepycat License
      SLEEPYCAT = "Sleepycat"
      # Standard ML of New Jersey License
      SMLNJ = "SMLNJ"
      # Secure Messaging Protocol Public License
      SMPPL = "SMPPL"
      # SNIA Public License 1.1
      SNIA = "SNIA"
      # snprintf License
      SNPRINTF = "snprintf"
      # softSurfer License
      SOFTSURFER = "softSurfer"
      # Soundex License
      SOUNDEX = "Soundex"
      # Spencer License 86
      SPENCER_86 = "Spencer-86"
      # Spencer License 94
      SPENCER_94 = "Spencer-94"
      # Spencer License 99
      SPENCER_99 = "Spencer-99"
      # Sun Public License v1.0
      SPL_1_0 = "SPL-1.0"
      # ssh-keyscan License
      SSH_KEYSCAN = "ssh-keyscan"
      # SSH OpenSSH license
      SSH_OPENSSH = "SSH-OpenSSH"
      # SSH short notice
      SSH_SHORT = "SSH-short"
      # SSLeay License - standalone
      SSLEAY_STANDALONE = "SSLeay-standalone"
      # Server Side Public License, v 1
      SSPL_1_0 = "SSPL-1.0"
      # Standard ML of New Jersey License
      STANDARDML_NJ = "StandardML-NJ"
      # SugarCRM Public License v1.1.3
      SUGARCRM_1_1_3 = "SugarCRM-1.1.3"
      # Sun PPP License
      SUN_PPP = "Sun-PPP"
      # Sun PPP License (2000)
      SUN_PPP_2000 = "Sun-PPP-2000"
      # SunPro License
      SUNPRO = "SunPro"
      # Scheme Widget Library (SWL) Software License Agreement
      SWL = "SWL"
      # swrule License
      SWRULE = "swrule"
      # Symlinks License
      SYMLINKS = "Symlinks"
      # TAPR Open Hardware License v1.0
      TAPR_OHL_1_0 = "TAPR-OHL-1.0"
      # TCL/TK License
      TCL = "TCL"
      # TCP Wrappers License
      TCP_WRAPPERS = "TCP-wrappers"
      # TermReadKey License
      TERMREADKEY = "TermReadKey"
      # Transitive Grace Period Public Licence 1.0
      TGPPL_1_0 = "TGPPL-1.0"
      # 3D Slicer License v1.0
      THREE_D_SLICER_1_0 = "3D-Slicer-1.0"
      # threeparttable License
      THREEPARTTABLE = "threeparttable"
      # TMate Open Source License
      TMATE = "TMate"
      # TORQUE v2.5+ Software License v1.1
      TORQUE_1_1 = "TORQUE-1.1"
      # Trusster Open Source License
      TOSL = "TOSL"
      # Time::ParseDate License
      TPDL = "TPDL"
      # THOR Public License 1.0
      TPL_1_0 = "TPL-1.0"
      # TrustedQSL License
      TRUSTEDQSL = "TrustedQSL"
      # Text-Tabs+Wrap License
      TTWL = "TTWL"
      # TTYP0 License
      TTYP0 = "TTYP0"
      # Technische Universitaet Berlin License 1.0
      TU_BERLIN_1_0 = "TU-Berlin-1.0"
      # Technische Universitaet Berlin License 2.0
      TU_BERLIN_2_0 = "TU-Berlin-2.0"
      # Ubuntu Font Licence v1.0
      UBUNTU_FONT_1_0 = "Ubuntu-font-1.0"
      # UCAR License
      UCAR = "UCAR"
      # Upstream Compatibility License v1.0
      UCL_1_0 = "UCL-1.0"
      # ulem License
      ULEM = "ulem"
      # Michigan/Merit Networks License
      UMICH_MERIT = "UMich-Merit"
      # Unicode License v3
      UNICODE_3_0 = "Unicode-3.0"
      # Unicode License Agreement - Data Files and Software (2015)
      UNICODE_DFS_2015 = "Unicode-DFS-2015"
      # Unicode License Agreement - Data Files and Software (2016)
      UNICODE_DFS_2016 = "Unicode-DFS-2016"
      # Unicode Terms of Use
      UNICODE_TOU = "Unicode-TOU"
      # UnixCrypt License
      UNIXCRYPT = "UnixCrypt"
      # The Unlicense
      UNLICENSE = "Unlicense"
      # Universal Permissive License v1.0
      UPL_1_0 = "UPL-1.0"
      # Utah Raster Toolkit Run Length Encoded License
      URT_RLE = "URT-RLE"
      # Vim License
      VIM = "Vim"
      # VOSTROM Public License for Open Source
      VOSTROM = "VOSTROM"
      # Vovida Software License v1.0
      VSL_1_0 = "VSL-1.0"
      # W3C Software Notice and License (2002-12-31)
      W3C = "W3C"
      # W3C Software Notice and License (1998-07-20)
      W3C_19980720 = "W3C-19980720"
      # W3C Software Notice and Document License (2015-05-13)
      W3C_20150513 = "W3C-20150513"
      # w3m License
      W3M = "w3m"
      # Sybase Open Watcom Public License 1.0
      WATCOM_1_0 = "Watcom-1.0"
      # Widget Workshop License
      WIDGET_WORKSHOP = "Widget-Workshop"
      # Wsuipa License
      WSUIPA = "Wsuipa"
      # Do What The F*ck You Want To Public License
      WTFPL = "WTFPL"
      # wxWindows Library License
      WXWINDOWS = "wxWindows"
      # X11 License
      X11 = "X11"
      # X11 License Distribution Modification Variant
      X11_DISTRIBUTE_MODIFICATIONS_VARIANT = "X11-distribute-modifications-variant"
      # X11 swapped final paragraphs
      X11_SWAPPED = "X11-swapped"
      # Xdebug License v 1.03
      XDEBUG_1_03 = "Xdebug-1.03"
      # Xerox License
      XEROX = "Xerox"
      # Xfig License
      XFIG = "Xfig"
      # XFree86 License 1.1
      XFREE86_1_1 = "XFree86-1.1"
      # xinetd License
      XINETD = "xinetd"
      # xkeyboard-config Zinoviev License
      XKEYBOARD_CONFIG_ZINOVIEV = "xkeyboard-config-Zinoviev"
      # xlock License
      XLOCK = "xlock"
      # X.Net License
      XNET = "Xnet"
      # XPP License
      XPP = "xpp"
      # XSkat License
      XSKAT = "XSkat"
      # xzoom License
      XZOOM = "xzoom"
      # Yahoo! Public License v1.0
      YPL_1_0 = "YPL-1.0"
      # Yahoo! Public License v1.1
      YPL_1_1 = "YPL-1.1"
      # Zed License
      ZED = "Zed"
      # Zeeff License
      ZEEFF = "Zeeff"
      # Zend License v2.0
      ZEND_2_0 = "Zend-2.0"
      # Zimbra Public License v1.3
      ZIMBRA_1_3 = "Zimbra-1.3"
      # Zimbra Public License v1.4
      ZIMBRA_1_4 = "Zimbra-1.4"
      # zlib License
      ZLIB = "Zlib"
      # zlib/libpng License with Acknowledgement
      ZLIB_ACKNOWLEDGEMENT = "zlib-acknowledgement"
      # Zope Public License 1.1
      ZPL_1_1 = "ZPL-1.1"
      # Zope Public License 2.0
      ZPL_2_0 = "ZPL-2.0"
      # Zope Public License 2.1
      ZPL_2_1 = "ZPL-2.1"
    end

    # License Acknowledgement - Declared licenses and concluded licenses represent two different stages in the licensing process within software development. Declared licenses refer to the initial intention of the software authors regarding the licensing terms under which their code is released. On the other hand, concluded licenses are the result of a comprehensive analysis of the project's codebase to identify and confirm the actual licenses of the components used, which may differ from the initially declared licenses. While declared licenses provide an upfront indication of the licensing intentions, concluded licenses offer a more thorough understanding of the actual licensing within a project, facilitating proper compliance and risk management. Observed licenses are defined in `@.evidence.licenses`. Observed licenses form the evidence necessary to substantiate a concluded license.
    module LicenseAcknowledgement
      # Declared licenses represent the initial intentions of authors regarding the licensing terms of their code.
      DECLARED = "declared"
      # Concluded licenses are verified and confirmed.
      CONCLUDED = "concluded"
    end

    # License Type
    module LicenseType
      # A license that grants use of software solely for the purpose of education or research.
      ACADEMIC = "academic"
      # A license covering use of software embedded in a specific piece of hardware.
      APPLIANCE = "appliance"
      # A Client Access License (CAL) allows client computers to access services provided by server software.
      CLIENT_ACCESS = "client-access"
      # A Concurrent User license (aka floating license) limits the number of licenses for a software application and licenses are shared among a larger number of users.
      CONCURRENT_USER = "concurrent-user"
      # A license where the core of a computer's processor is assigned a specific number of points.
      CORE_POINTS = "core-points"
      # A license for which consumption is measured by non-standard metrics.
      CUSTOM_METRIC = "custom-metric"
      # A license that covers a defined number of installations on computers and other types of devices.
      DEVICE = "device"
      # A license that grants permission to install and use software for trial purposes.
      EVALUATION = "evaluation"
      # A license that grants access to the software to one or more pre-defined users.
      NAMED_USER = "named-user"
      # A license that grants access to the software on one or more pre-defined computers or devices.
      NODE_LOCKED = "node-locked"
      # An Original Equipment Manufacturer license that is delivered with hardware, cannot be transferred to other hardware, and is valid for the life of the hardware.
      OEM = "oem"
      # A license where the software is sold on a one-time basis and the licensee can use a copy of the software indefinitely.
      PERPETUAL = "perpetual"
      # A license where each installation consumes points per processor.
      PROCESSOR_POINTS = "processor-points"
      # A license where the licensee pays a fee to use the software or service.
      SUBSCRIPTION = "subscription"
      # A license that grants access to the software or service by a specified number of users.
      USER = "user"
      # Another license type.
      OTHER = "other"
    end

    # Mode - The mode of operation in which the cryptographic algorithm (block cipher) is used.
    module AlgorithmMode
      # Cipher block chaining
      CBC = "cbc"
      # Electronic codebook
      ECB = "ecb"
      # Counter with cipher block chaining message authentication code
      CCM = "ccm"
      # Galois/counter
      GCM = "gcm"
      # Cipher feedback
      CFB = "cfb"
      # Output feedback
      OFB = "ofb"
      # Counter
      CTR = "ctr"
      # Another mode of operation
      OTHER = "other"
      # The mode of operation is not known
      UNKNOWN = "unknown"
    end

    # Output Type - Describes the type of data output.
    module OutputType
      ARTIFACT = "artifact"
      ATTESTATION = "attestation"
      LOG = "log"
      EVIDENCE = "evidence"
      METRICS = "metrics"
      OTHER = "other"
    end

    # Padding - The padding scheme that is used for the cryptographic algorithm.
    module Padding
      # Public Key Cryptography Standard: Password-Based Cryptography
      PKCS5 = "pkcs5"
      # Public Key Cryptography Standard: Cryptographic Message Syntax
      PKCS7 = "pkcs7"
      # Public Key Cryptography Standard: RSA Cryptography v1.5
      PKCS1V15 = "pkcs1v15"
      # Optimal asymmetric encryption padding
      OAEP = "oaep"
      # Raw
      RAW = "raw"
      # Another padding scheme
      OTHER = "other"
      # The padding scheme is not known
      UNKNOWN = "unknown"
    end

    # Patch Type - Specifies the purpose for the patch including the resolution of defects, security issues, or new behavior or functionality.
    module PatchType
      # A patch which is not developed by the creators or maintainers of the software being patched. Refer to [https://en.wikipedia.org/wiki/Unofficial_patch](https://en.wikipedia.org/wiki/Unofficial_patch).
      UNOFFICIAL = "unofficial"
      # A patch which dynamically modifies runtime behavior. Refer to [https://en.wikipedia.org/wiki/Monkey_patch](https://en.wikipedia.org/wiki/Monkey_patch).
      MONKEY = "monkey"
      # A patch which takes code from a newer version of the software and applies it to older versions of the same software. Refer to [https://en.wikipedia.org/wiki/Backporting](https://en.wikipedia.org/wiki/Backporting).
      BACKPORT = "backport"
      # A patch created by selectively applying commits from other versions or branches of the same software.
      CHERRY_PICK = "cherry-pick"
    end

    # Phase - A pre-defined phase in the product lifecycle.
    module Phase
      # BOM produced early in the development lifecycle containing an inventory of components and services that are proposed or planned to be used. The inventory may need to be procured, retrieved, or resourced prior to use.
      DESIGN = "design"
      # BOM consisting of information obtained prior to a build process and may contain source files and development artifacts and manifests. The inventory may need to be resolved and retrieved prior to use.
      PRE_BUILD = "pre-build"
      # BOM consisting of information obtained during a build process where component inventory is available for use. The precise versions of resolved components are usually available at this time as well as the provenance of where the components were retrieved from.
      BUILD = "build"
      # BOM consisting of information obtained after a build process has completed and the resulting components(s) are available for further analysis. Built components may exist as the result of a CI/CD process, may have been installed or deployed to a system or device, and may need to be retrieved or extracted from the system or device.
      POST_BUILD = "post-build"
      # BOM produced that represents inventory that is running and operational. This may include staging or production environments and will generally encompass multiple SBOMs describing the applications and operating system, along with HBOMs describing the hardware that makes up the system. Operations Bill of Materials (OBOM) can provide full-stack inventory of runtime environments, configurations, and additional dependencies.
      OPERATIONS = "operations"
      # BOM consisting of information observed through network discovery providing point-in-time enumeration of embedded, on-premise, and cloud-native services such as server applications, connected devices, microservices, and serverless functions.
      DISCOVERY = "discovery"
      # BOM containing inventory that will be, or has been retired from operations.
      DECOMMISSION = "decommission"
    end

    # primitive - Cryptographic building blocks used in higher-level cryptographic systems and protocols. Primitives represent different cryptographic routines: deterministic random bit generators (drbg, e.g. CTR_DRBG from NIST SP800-90A-r1), message authentication codes (mac, e.g. HMAC-SHA-256), blockciphers (e.g. AES), streamciphers (e.g. Salsa20), signatures (e.g. ECDSA), hash functions (e.g. SHA-256), public-key encryption schemes (pke, e.g. RSA), extended output functions (xof, e.g. SHAKE256), key derivation functions (e.g. pbkdf2), key agreement algorithms (e.g. ECDH), key encapsulation mechanisms (e.g. ML-KEM), authenticated encryption (ae, e.g. AES-GCM) and the combination of multiple algorithms (combiner, e.g. SP800-56Cr2).
    module Primitive
      # Deterministic Random Bit Generator (DRBG) is a type of pseudorandom number generator designed to produce a sequence of bits from an initial seed value. DRBGs are commonly used in cryptographic applications where reproducibility of random values is important.
      DRBG = "drbg"
      # In cryptography, a Message Authentication Code (MAC) is information used for authenticating and integrity-checking a message.
      MAC = "mac"
      # A block cipher is a symmetric key algorithm that operates on fixed-size blocks of data. It encrypts or decrypts the data in block units, providing confidentiality. Block ciphers are widely used in various cryptographic modes and protocols for secure data transmission.
      BLOCK_CIPHER = "block-cipher"
      # A stream cipher is a symmetric key cipher where plaintext digits are combined with a pseudorandom cipher digit stream (keystream).
      STREAM_CIPHER = "stream-cipher"
      # In cryptography, a signature is a digital representation of a message or data that proves its origin, identity, and integrity. Digital signatures are generated using cryptographic algorithms and are widely used for authentication and verification in secure communication.
      SIGNATURE = "signature"
      # A hash function is a mathematical algorithm that takes an input (or 'message') and produces a fixed-size string of characters, which is typically a hash value. Hash functions are commonly used in various cryptographic applications, including data integrity verification and password hashing.
      HASH = "hash"
      # Public Key Encryption (PKE) is a type of encryption that uses a pair of public and private keys for secure communication. The public key is used for encryption, while the private key is used for decryption. PKE is a fundamental component of public-key cryptography.
      PKE = "pke"
      # An XOF is an extendable output function that can take arbitrary input and creates a stream of output, up to a limit determined by the size of the internal state of the hash function that underlies the XOF.
      XOF = "xof"
      # A Key Derivation Function (KDF) derives key material from another source of entropy while preserving the entropy of the input.
      KDF = "kdf"
      # In cryptography, a key-agreement is a protocol whereby two or more parties agree on a cryptographic key in such a way that both influence the outcome.
      KEY_AGREE = "key-agree"
      # A Key Encapsulation Mechanism (KEM) algorithm is a mechanism for transporting random keying material to a recipient using the recipient's public key.
      KEM = "kem"
      # Authenticated Encryption (AE) is a cryptographic process that provides both confidentiality and data integrity. It ensures that the encrypted data has not been tampered with and comes from a legitimate source. AE is commonly used in secure communication protocols.
      AE = "ae"
      # A combiner aggregates many candidates for a cryptographic primitive and generates a new candidate for the same primitive.
      COMBINER = "combiner"
      # Another primitive type.
      OTHER = "other"
      # The primitive is not known.
      UNKNOWN = "unknown"
    end

    # Protocol Type - The concrete protocol type.
    module ProtocolType
      # Transport Layer Security
      TLS = "tls"
      # Secure Shell
      SSH = "ssh"
      # Internet Protocol Security
      IPSEC = "ipsec"
      # Internet Key Exchange
      IKE = "ike"
      # Secure Socket Tunneling Protocol
      SSTP = "sstp"
      # Wi-Fi Protected Access
      WPA = "wpa"
      # Another protocol type
      OTHER = "other"
      # The protocol type is not known
      UNKNOWN = "unknown"
    end

    # Related Crypto Material Type - The type for the related cryptographic material
    module RelatedCryptoMaterialType
      # The confidential key of a key pair used in asymmetric cryptography.
      PRIVATE_KEY = "private-key"
      # The non-confidential key of a key pair used in asymmetric cryptography.
      PUBLIC_KEY = "public-key"
      # A key used to encrypt and decrypt messages in symmetric cryptography.
      SECRET_KEY = "secret-key"
      # A piece of information, usually an octet string, which, when processed through a cryptographic algorithm, processes cryptographic data.
      KEY = "key"
      # The result of encryption performed on plaintext using an algorithm (or cipher).
      CIPHERTEXT = "ciphertext"
      # A cryptographic value that is calculated from the data and a key known only by the signer.
      SIGNATURE = "signature"
      # The output of the hash function.
      DIGEST = "digest"
      # A fixed-size random or pseudo-random value used as an input parameter for cryptographic algorithms.
      INITIALIZATION_VECTOR = "initialization-vector"
      # A random or pseudo-random number that can only be used once in a cryptographic communication.
      NONCE = "nonce"
      # The input to a pseudo-random number generator. Different seeds generate different pseudo-random sequences.
      SEED = "seed"
      # A value used in a cryptographic process, usually to ensure that the results of computations for one instance cannot be reused by an attacker.
      SALT = "salt"
      # A piece of data known only to the parties involved, in a secure communication.
      SHARED_SECRET = "shared-secret"
      # A message authentication code (MAC), sometimes known as an authentication tag, is a short piece of information used for authenticating and integrity-checking a message.
      TAG = "tag"
      # An unspecified collection of data with relevance to cryptographic activity.
      ADDITIONAL_DATA = "additional-data"
      # A secret word, phrase, or sequence of characters used during authentication or authorization.
      PASSWORD = "password"
      # Establishes the identity of a party to communication, usually in the form of cryptographic keys or passwords.
      CREDENTIAL = "credential"
      # An object encapsulating a security identity.
      TOKEN = "token"
      # Another type of cryptographic asset.
      OTHER = "other"
      # The type of cryptographic asset is not known.
      UNKNOWN = "unknown"
    end

    # Related Crypto Material State - The key state as defined by NIST SP 800-57.
    module RelatedCryptoMaterialState
      PRE_ACTIVATION = "pre-activation"
      ACTIVE = "active"
      SUSPENDED = "suspended"
      DEACTIVATED = "deactivated"
      COMPROMISED = "compromised"
      DESTROYED = "destroyed"
    end

    # Response
    module Response
      # Can not fix
      CAN_NOT_FIX = "can_not_fix"
      # Will not fix
      WILL_NOT_FIX = "will_not_fix"
      # Update to a different revision or release
      UPDATE = "update"
      # Revert to a previous revision or release
      ROLLBACK = "rollback"
      # There is a workaround available
      WORKAROUND_AVAILABLE = "workaround_available"
    end

    # Component Scope - Specifies the scope of the component. If scope is not specified, 'required' scope SHOULD be assumed by the consumer of the BOM.
    module Scope
      # The component is required for runtime
      REQUIRED = "required"
      # The component is optional at runtime. Optional components are components that are not capable of being called due to them not being installed or otherwise accessible by any means. Components that are installed but due to configuration or other restrictions are prohibited from being called must be scoped as 'required'.
      OPTIONAL = "optional"
      # Components that are excluded provide the ability to document component usage for test and other non-runtime purposes. Excluded components are not reachable within a call graph at runtime.
      EXCLUDED = "excluded"
    end

    # Method - Specifies the severity or risk scoring methodology or standard used.
    module ScoreMethod
      # Common Vulnerability Scoring System v2.0
      CVS_SV2 = "CVSSv2"
      # Common Vulnerability Scoring System v3.0
      CVS_SV3 = "CVSSv3"
      # Common Vulnerability Scoring System v3.1
      CVS_SV31 = "CVSSv31"
      # Common Vulnerability Scoring System v4.0
      CVS_SV4 = "CVSSv4"
      # OWASP Risk Rating Methodology
      OWASP = "OWASP"
      # Stakeholder Specific Vulnerability Categorization
      SSVC = "SSVC"
      # Another severity or risk scoring methodology
      OTHER = "other"
    end

    # Anonymous class from TaskType
    module TaskType
      # A task that copies software or data used to accomplish other tasks in the workflow.
      COPY = "copy"
      # A task that clones a software repository into the workflow in order to retrieve its source code or data for use in a build step.
      CLONE = "clone"
      # A task that checks source code for programmatic and stylistic errors.
      LINT = "lint"
      # A task that performs a scan against source code, or built or deployed components and services. Scans are typically run to gather or test for security vulnerabilities or policy compliance.
      SCAN = "scan"
      # A task that merges changes or fixes into source code prior to a build step in the workflow.
      MERGE = "merge"
      # A task that builds the source code, dependencies and/or data into an artifact that can be deployed to and executed on target systems.
      BUILD = "build"
      # A task that verifies the functionality of a component or service.
      TEST = "test"
      # A task that delivers a built artifact to one or more target repositories or storage systems.
      DELIVER = "deliver"
      # A task that deploys a built artifact for execution on one or more target systems.
      DEPLOY = "deploy"
      # A task that releases a built, versioned artifact to a target repository or distribution system.
      RELEASE = "release"
      # A task that cleans unnecessary tools, build artifacts and/or data from workflow storage.
      CLEAN = "clean"
      # A workflow task that does not match current task type definitions.
      OTHER = "other"
    end

    # Technique - The technique used in this method of analysis.
    module Technique
      SOURCE_CODE_ANALYSIS = "source-code-analysis"
      BINARY_ANALYSIS = "binary-analysis"
      MANIFEST_ANALYSIS = "manifest-analysis"
      AST_FINGERPRINT = "ast-fingerprint"
      HASH_COMPARISON = "hash-comparison"
      INSTRUMENTATION = "instrumentation"
      DYNAMIC_ANALYSIS = "dynamic-analysis"
      FILENAME = "filename"
      ATTESTATION = "attestation"
      OTHER = "other"
    end

    module TriggerType
      MANUAL = "manual"
      API = "api"
      WEBHOOK = "webhook"
      SCHEDULED = "scheduled"
    end

    module VolumeMode
      FILESYSTEM = "filesystem"
      BLOCK = "block"
    end
  end
end
