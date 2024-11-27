# frozen_string_literal: true

require_relative "base"
require_relative "../validator"

# Signature - Enveloped signature in [JSON Signature Format (JSF)](https://cyberphone.github.io/doc/security/jsf.html).
module SBOM
  module CycloneDX
    module Record
      module Signature
        # Schema name: JSFSignature
        class JSFSignature < Base
          module PublicKey
            # Schema name: ECPublicKey
            class EC < Base
              const :kty, :string, "EC"
              prop :crv, :string, enum: Enum::SIGNATURE_EC_CRV, required: true
              prop :x, :string, required: true
              prop :y, :string, required: true
            end

            # Schema name: OKPPublicKey
            class OKP < Base
              const :kty, :string, "OKP"
              prop :crv, :string, enum: Enum::SIGNATURE_OKP_CRV, required: true
              prop :x, :string, required: true
            end

            # Schema name: RSAPublicKey
            class RSA < Base
              const :kty, :string, "RSA"
              prop :n, :string, required: true
              prop :e, :string, required: true
            end

            UNION_TYPE = [EC, OKP, RSA].freeze #: [singleton(EC), singleton(OKP), singleton(RSA)]

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
          end

          prop :algorithm, :union, of: [:uri, [:string, enum: Enum::SIGNATURE_ALGORITHM]], required: true
          prop :key_id, :string
          prop :public_key, :union, of: PublicKey::UNION_TYPE
          prop :certificate_path, :array, items: :string
          prop :excludes, :array, items: :string
          prop :value, :string, required: true
        end

        # Schema name: SignatureChain
        class SignatureChain < Base
          prop :signatures, :array, items: JSFSignature, json_name: "chain"
        end

        # Schema name: SignatureList
        class SignerList < Base
          prop :signers, :array, items: JSFSignature
        end

        UNION_TYPE = [JSFSignature, SignatureChain, SignerList].freeze #: [singleton(JSFSignature), singleton(SignatureChain), singleton(SignerList)]
      end
    end
  end
end
