# frozen_string_literal: true

module SBOM
  module CycloneDX
    module SchemaObject
      def self.included(base)
        raise ArgumentError, "SchemaObject must be included in a Struct" unless base < Struct

        super
        base.extend(ClassMethods)
      end

      def valid?
        raise NotImplementedError, "valid? must be implemented by the concrete class"
      end

      def to_json(*_args)
        raise SBOM::CycloneDX::Error, "Object is not valid" unless valid?

        to_h
          .transform_keys { |k| json_name_for(k) }
          .to_json
      end

      def json_name_for(member_name)
        self.class.json_name_for(member_name)
      end

      module ClassMethods
        def self.extended(base)
          super
          raise ArgumentError, "This module can only be extended by a SchemaObject" unless base < SchemaObject

          define_method(:concrete_klass) { base }
          private :concrete_klass
        end

        def valid?(object, required: false)
          Validator.valid?(concrete_klass, object, required: required)
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
