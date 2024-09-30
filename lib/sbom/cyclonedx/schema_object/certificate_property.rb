# frozen_string_literal: true
# rbs_inline: enabled

# Certificate Properties - Properties for cryptographic assets of asset type 'certificate'
module Sbom
  module Cyclonedx
    class CertificateProperty < SchemaObject
      # Subject Name - The subject name for the certificate
      attr_accessor :subject_name #: String

      # Issuer Name - The issuer name for the certificate
      attr_accessor :issuer_name #: String

      # Not Valid Before - The date and time according to ISO-8601 standard from which the certificate is valid
      attr_accessor :not_valid_before #: DateTime

      # Not Valid After - The date and time according to ISO-8601 standard from which the certificate is not valid anymore
      attr_accessor :not_valid_after #: DateTime

      # Algorithm Reference - The bom-ref to signature algorithm used by the certificate
      attr_accessor :signature_algorithm_ref #: RefLink

      # Key reference - The bom-ref to the public key of the subject
      attr_accessor :subject_public_key_ref #: RefLink

      # Certificate Format - The format of the certificate
      # Examples: "X.509", "PEM", "DER", "CVC"
      attr_accessor :certificate_format #: String

      # Certificate File Extension - The file extension of the certificate
      # Examples: "crt", "pem", "cer", "der", "p12"
      attr_accessor :certificate_extension #: String
    end
  end
end
