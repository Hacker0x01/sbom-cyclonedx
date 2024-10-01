# frozen_string_literal: true
# rbs_inline: enabled

# Copyright - A copyright notice informing users of the underlying claims to copyright ownership in a published work.
module SBOM
  module Cyclonedx
    class Copyright < SchemaObject
      # Copyright Text - The textual content of the copyright.
      attr_accessor :text #: String
    end
  end
end
