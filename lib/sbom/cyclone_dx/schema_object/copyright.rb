# frozen_string_literal: true
# rbs_inline: enabled

# Copyright - A copyright notice informing users of the underlying claims to copyright ownership in a published work.
module SBOM
  module CycloneDX
    Copyright = SchemaObject.build("Copyright") do
      # Copyright Text - The textual content of the copyright.
      prop :text, String, required: true
    end
  end
end
