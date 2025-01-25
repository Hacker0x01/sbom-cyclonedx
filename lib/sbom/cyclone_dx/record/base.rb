# frozen_string_literal: true

require "active_support/all"
require_relative "../../../email_address_extension"
require_relative "../enum"
require_relative "../pattern"
require_relative "../validator"

module SBOM
  module CycloneDX
    module Record
      class Base # rubocop:disable Metrics/ClassLength
        include Comparable

        attr_reader :errors

        def initialize(**args)
          raise "Cannot instantiate abstract Record" unless self.class < Base

          populate_fields(**args)
          valid?
        end

        def <=>(other)
          return nil unless other.is_a?(self.class)

          as_json <=> other.as_json
        end

        def valid?
          @errors = @_fields.transform_values do |field|
            field.valid?
            field.errors
          end
          @errors[:_base] = []

          self.class.custom_validators.each do |props, message, block|
            @errors[:_base] += validate_custom(*props, message: message, &block)
          end

          @errors.values.all?(&:empty?)
        end

        def valid!
          raise ArgumentError, formatted_errors
        end

        def formatted_errors
          errors.filter_map do |field_name, field_errors|
            next if field_errors.empty?

            field_name = self.class.json_name if field_name == :_base
            field_errors.map { |error| "#{field_name} #{error}" }
          end.flatten
        end

        def self.json_create(object)
          new(**object.deep_symbolize_keys)
        end

        private

        attr_reader :_fields

        def populate_fields(**args) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
          @_fields = self.class.fields.to_h do |name, field_class|
            arg_name =
              if args.key?(name)
                name
              elsif args.key?(field_class.json_name.to_sym)
                field_class.json_name.to_sym
              end

            unless arg_name.nil?
              raise ArgumentError, "Can not reassign a const field" if field_class < Field::ConstBase
              next [name, field_class.new(field_class.coerce(args.delete(arg_name)))] if field_class < Field::PropBase
            end

            [name, field_class.new]
          end

          raise ArgumentError, "Unknown field(s): #{args.keys.join(", ")}" unless args.empty?

          @_fields
        end

        def validate_custom(*props, message: nil) # rubocop:disable Metrics/MethodLength
          case rv = yield(*props.map { |prop| public_send(prop) })
          when "", true, nil
            []
          when String
            [rv]
          when Array
            rv
          when false
            [message || "#{props.join(", ")} invalid"]
          else
            [rv.to_s]
          end
        end

        class << self
          def fields
            @fields ||= {} #: Hash[Symbol, singleton(SBOM::CycloneDX::Field::Base)]
          end

          def json_name(klass_name = nil)
            unless klass_name.nil?
              raise ArgumentError, "json_name can only be set within the class body" unless in_subclass_body?

              return @json_name = klass_name
            end

            @json_name ||= name&.split("::")&.last || "Record"
          end

          ###############################
          # DSL Methods
          ###############################

          def prop(field_name, type, required: false, json_name: nil, **kwargs) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength
            raise "properties cannot be defined for abstract Record" unless self < Base
            raise "properties must be defined in the class body of a subclass of Record" unless in_subclass_body?
            raise "property #{field_name} already defined" if fields.key?(field_name)

            new_prop =
              case type
              when :array
                opts = kwargs.slice(:const, :default, :unique) #: arrayFieldOptions
                Field.array(field_name: field_name, items: kwargs.fetch(:items), required: required,
                            json_name: json_name, **opts)
              when :boolean
                opts = kwargs.slice(:const, :default) #: booleanFieldOptions
                Field.boolean(field_name: field_name, required: required, json_name: json_name, **opts)
              when :date_time
                opts = kwargs.slice(:const, :default) #: dateTimeFieldOptions
                Field.date_time(field_name: field_name,  required: required, json_name: json_name, **opts)
              when :email_address
                opts = kwargs.slice(:const, :default) #: emailAddressFieldOptions
                Field.email_address(field_name: field_name, required: required, json_name: json_name, **opts)
              when :float
                opts = kwargs.slice(:const, :default, :maximum, :minimum) #: floatFieldOptions
                Field.float(field_name: field_name, required: required, json_name: json_name, **opts)
              when :integer
                opts = kwargs.slice(:const, :default, :maximum, :minimum) #: integerFieldOptions
                Field.integer(field_name: field_name, required: required, json_name: json_name, **opts)
              when Class
                opts = kwargs.slice(:const, :default) #: recordFieldOptions
                Field.record(field_name: field_name, klass: type, required: required, json_name: json_name, **opts)
              when :string
                opts = kwargs.slice(:const, :default, :enum, :max_length, :min_length, :pattern) #: stringFieldOptions
                Field.string(field_name: field_name,  required: required, json_name: json_name, **opts)
              when :union
                opts = kwargs.slice(:const, :default) #: unionFieldOptions
                Field.union(field_name: field_name, of: kwargs.fetch(:of), required: required, json_name: json_name,
                            **opts)
              when :uri
                opts = kwargs.slice(:const, :default) #: uriFieldOptions
                Field.uri(field_name: field_name, required: required, json_name: json_name, **opts)
              else
                raise ArgumentError, "unknown type: #{type}"
              end

            @fields[field_name] = new_prop
            define_method(field_name) { @_fields.fetch(field_name).value }
            define_method(:"#{field_name}=") { |value| @_fields.fetch(field_name).value = value } unless new_prop.const?
            define_method(:"#{field_name}?") { @_fields.fetch(field_name).value? }
            define_method(:"#{field_name}_valid?") { @_fields.fetch(field_name).valid? }
          end

          def const(field_name, type, value, required: false, json_name: nil, **kwargs)
            prop(field_name, type, required: required, json_name: json_name, const: value, **kwargs)
          end

          def validate(*props, presence: nil, message: nil, &block) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength
            raise "custom validators cannot be defined for abstract Record" unless self < Base
            raise "custom validators must be defined in the class body of a subclass of Record" unless in_subclass_body?

            @custom_validators ||= [] #: Array[[Array[Symbol], String, ^(*fieldValue?) -> (bool? | String | Array[String])]]
            @custom_validators <<
              if presence && block
                raise ArgumentError, "cannot provide both :presence and a block"
              elsif presence
                validate_presence(props, presence, message)
              elsif block
                [props, message, block]
              else
                raise ArgumentError, "must provide :presence or a block"
              end
          end

          def custom_validators
            @custom_validators ||= []
          end

          private

          def in_subclass_body? # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
            caller_location = caller_locations&.find do |location|
              !location.label&.include?("__RBS_TEST") && location.path != __FILE__
            end

            self < Base && (caller_location&.label&.start_with?("<class:") || false)
          end

          def validate_presence(props, presence, message = nil) # rubocop:disable Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
            case presence
            when :all
              [
                props,
                message || "all of #{props.join(", ")} must be present",
                ->(*values) { values.none?(&:nil?) }
              ]
            when :any
              [
                props,
                message || "at least one of #{props.join(", ")} must be present",
                ->(*values) { !values.all?(&:nil?) }
              ]
            when :one
              [
                props,
                message || "exactly one of #{props.join(", ")} must be present",
                ->(*values) { values.count { |v| !v.nil? } == 1 }
              ]
            else
              raise ArgumentError, "unknown value for presence: #{presence}"
            end
          end
        end
      end
    end
  end
end
