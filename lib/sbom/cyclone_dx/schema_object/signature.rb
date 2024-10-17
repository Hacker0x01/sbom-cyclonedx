# frozen_string_literal: true

require_relative "../schema_object"
require_relative "../validator"

# Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
module SBOM
  module CycloneDX
    module Signature
      def self.valid?(signature, required: false)
        return false if required && signature.nil?

        [JSFSignature, SignatureChain, SignerList].any? { |klass| Validator.valid?(klass, signature, required: true) }
      end

      class JSFSignature < Struct.new(
        "JSFSignature",
        :algorithm,
        :key_id,
        :public_key,
        :certificate_path,
        :excludes,
        :value,
        keyword_init: true
      )
        include SchemaObject

        def initialize(algorithm:, value:, key_id: nil, public_key: nil, certificate_path: nil, excludes: nil)
          super
        end

        def valid?
          Validator.valid?(SBOM::CycloneDX::Type::Union, algorithm, klasses: [URI, String],
                                                                    enum: Enum::SIGNATURE_ALGORITHM, required: true) &&
            Validator.valid?(String, key_id) &&
            PublicKey.valid?(public_key) &&
            Validator.valid?(Array, certificate_path, items: String) &&
            Validator.valid?(Array, excludes, items: String) &&
            Validator.valid?(String, value, required: true)
        end

        module PublicKey
          def self.new(kty:, crv: nil, x: nil, y: nil, n: nil, e: nil) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
            case kty
            when "EC"
              raise "`n` and `e` must be nil when kty == \"EC\"" unless n.nil? && e.nil?
              if crv.nil? || x.nil? || y.nil?
                raise ArgumentError, "`crv`, `x`, and `y` must not be nil when kty == \"EC\""
              end

              EC.new(crv: crv, x: x, y: y)
            when "OKP"
              raise "`y`, `n` and `e` must be nil when kty == \"OKP\"" unless y.nil? && n.nil? && e.nil?
              raise ArgumentError, "`crv` and `x` must not be nil when kty == \"OKP\"" if crv.nil? || x.nil?

              OKP.new(crv: crv, x: x)
            when "RSA"
              raise "`crv`, `x`, and `y` must be nil when kty == \"RSA\"" unless crv.nil? && x.nil? && y.nil?
              raise ArgumentError, "`n` and `e` must not be nil when kty == \"RSA\"" if n.nil? || e.nil?

              RSA.new(n: n, e: e)
            else
              raise ArgumentError, "Invalid value for `kty`"
            end
          end

          def self.valid?(object, **type_specific_args)
            Validator.valid?(SBOM::CycloneDX::Type::Union, object, klasses: [EC, OKP, RSA], **type_specific_args)
          end

          class EC < Struct.new("ECPublicKey", :kty, :crv, :x, :y, keyword_init: true)
            include SchemaObject

            def initialize(crv:, x:, y:) # rubocop:disable Naming/MethodParameterName
              super(kty: "EC", crv: crv, x: x, y: y)
            end

            def valid?
              Validator.valid?(String, kty, const: "EC", required: true) &&
                Validator.valid?(String, crv, enum: Enum::SIGNATURE_EC_CRV, required: true) &&
                Validator.valid?(String, x, required: true) &&
                Validator.valid?(String, y, required: true)
            end
          end

          class OKP < Struct.new("OKPPublicKey", :kty, :crv, :x, keyword_init: true)
            include SchemaObject

            def initialize(crv:, x:) # rubocop:disable Naming/MethodParameterName
              super(kty: "OKP", crv: crv, x: x)
            end

            def valid?
              Validator.valid?(String, kty, const: "OKP", required: true) &&
                Validator.valid?(String, crv, enum: Enum::SIGNATURE_OKP_CRV, required: true) &&
                Validator.valid?(String, x, required: true)
            end
          end

          class RSA < Struct.new("RSAPublicKey", :kty, :n, :e, keyword_init: true)
            include SchemaObject

            def initialize(n:, e:) # rubocop:disable Naming/MethodParameterName
              super(kty: "RSA", n: n, e: e)
            end

            def valid?
              Validator.valid?(String, kty, const: "RSA", required: true) &&
                Validator.valid?(String, n, required: true) &&
                Validator.valid?(String, e, required: true)
            end
          end
        end
      end

      class SignatureChain < Struct.new("SignatureChain", :signatures, keyword_init: true)
        include SchemaObject

        json_name :signatures, "chain"

        def valid?
          Validator.valid?(Array, signatures, items: JSFSignature)
        end
      end

      class SignerList < Struct.new("SignatureList", :signers, keyword_init: true)
        include SchemaObject

        def valid?
          Validator.valid?(Array, signers, items: JSFSignature)
        end
      end
    end
  end
end
