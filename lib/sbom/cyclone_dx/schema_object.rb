# frozen_string_literal: true

require "debug"
require "active_support/all"
require_relative "email_address"
require_relative "enum"
require_relative "pattern"
require_relative "type"
require_relative "validator"

module SBOM
  module CycloneDX
    module SchemaObject
      def self.included(base)
        raise ArgumentError, "SchemaObject must be included in a Struct" unless base < Struct

        super

        base.extend(ClassMethods)
      end

      def initialize(**args)
        # Type-checking complains about the use of `super` here, but it is safe to use
        # since we ensure this module is included in a Struct
        super_method = method(__method__ || :initialize).super_method
        super_method&.call(**args) if super_method&.owner == ::Struct

        valid?
      end

      def valid?
        raise NotImplementedError, "valid? must be implemented by the concrete class"
      end

      def as_json(_args = nil)
        raise SBOM::CycloneDX::Error, "Object is not valid" unless valid?

        # Struct#to_h does not take a block, but returns a hash
        to_h.to_h do |k, v|
          [json_name_for(k), v.as_json]
        end
      end

      def to_json(*_args)
        raise SBOM::CycloneDX::Error, "Object is not valid" unless valid?

        as_json.to_json
      end

      private

      def json_name_for(member_name)
        self.class.json_name_for(member_name)
      end

      module ClassMethods
        def self.extended(base)
          super
          raise ArgumentError, "This module can only be extended by a SchemaObject" unless base < SchemaObject
        end

        def json_name_for(member_name)
          json_name_map[member_name]
        end

        def json_name(member_name, string_name)
          json_name_map[member_name] = string_name
        end

        private

        def json_name_map
          @json_name_map ||= Hash.new { |h, k| h[k] = k.to_s.camelize(:lower) }
        end
      end
    end
  end
end
