# frozen_string_literal: true
# rbs_inline: enabled

# Hash
module Sbom
  module Cyclonedx
    class Hash < SchemaObject
      attr_accessor :alg #: HashAlg

      attr_accessor :content #: HashContent
    end
  end
end
