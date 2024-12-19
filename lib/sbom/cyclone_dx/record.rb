# frozen_string_literal: true

Dir[File.join(__dir__ || ".", "record", "*.rb")].each do |file|
  require_relative file
end

module SBOM
  module CycloneDX
    module Record
    end
  end
end
