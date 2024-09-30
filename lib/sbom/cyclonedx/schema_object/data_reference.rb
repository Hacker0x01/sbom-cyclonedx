# frozen_string_literal: true
# rbs_inline: enabled

# Data Reference
module Sbom
  module Cyclonedx
    class DataReference < SchemaObject
      # Reference - References a data component by the components bom-ref attribute
      attr_accessor :ref #: RefLink | BOMLinkElement
    end
  end
end
