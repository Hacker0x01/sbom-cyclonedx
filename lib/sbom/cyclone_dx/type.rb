# frozen_string_literal: true

module SBOM
  module CycloneDX
    module Type
      # Boolean and Union are used for our manual type-checking, in case the consuming code does not support RBS
      module Boolean
        def self.extended(_base)
          raise NotImplementedError, "This is an internal placeholder module and should not be extended"
        end

        def self.included(_base)
          raise NotImplementedError, "This is an internal placeholder module and should not be included"
        end
      end

      module Union
        def self.extended(_base)
          raise NotImplementedError, "This is an internal placeholder module and should not be extended"
        end

        def self.included(_base)
          raise NotImplementedError, "This is an internal placeholder module and should not be included"
        end
      end
    end
  end
end
