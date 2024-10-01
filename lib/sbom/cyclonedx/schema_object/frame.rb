# frozen_string_literal: true
# rbs_inline: enabled

# Frame
module SBOM
  module Cyclonedx
    class Frame < SchemaObject
      # Package - A package organizes modules into namespaces, providing a unique namespace for each type it contains.
      attr_accessor :package #: String

      # Module - A module or class that encloses functions/methods and other code.
      attr_accessor :module #: String

      # Function - A block of code designed to perform a particular task.
      attr_accessor :function #: String

      # Parameters - Optional arguments that are passed to the module or function.
      attr_accessor :parameters #: [String]

      # Line - The line number the code that is called resides on.
      attr_accessor :line #: Integer

      # Column - The column the code that is called resides.
      attr_accessor :column #: Integer

      # Full Filename - The full path and filename of the module.
      attr_accessor :full_filename #: String
    end
  end
end
