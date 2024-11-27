# frozen_string_literal: true

require_relative "base"

# Copyright - A copyright notice informing users of the underlying claims to copyright ownership in a published work.
module SBOM
  module CycloneDX
    module Record
      # Schema name: Copyright
      class Copyright < Base
        # Copyright Text - The textual content of the copyright.
        prop :text, :string, required: true
      end
    end
  end
end
