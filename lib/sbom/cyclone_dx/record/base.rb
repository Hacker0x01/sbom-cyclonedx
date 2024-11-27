# frozen_string_literal: true

require "active_support/all"
require_relative "../email_address"
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
          populate_consts_and_defaults

          valid?
        end

        def <=>(other)
          return nil unless other.is_a?(self.class)

          self.class.fields.each_key do |name|
            cmp = public_send(name) <=> other.public_send(name)
            return cmp unless cmp.zero?
          end

          0
        end

        def valid?
          @errors = self.class.prop_names.to_h { |name| [name, validate_value(name).presence] }.compact

          @errors.merge!(
            self.class.custom_validators.to_h do |(props, message, block)|
              [props.join(", "), validate_custom(*props, message: message, &block)]
            end.compact
          )

          @errors.empty?
        end

        def as_json(options = nil)
          raise SBOM::CycloneDX::Error, "Record is not valid" unless valid?

          self.class.prop_names(include_const: true).each_with_object({}) do |name, memo| #$ Hash[String, jsonObject]
            next unless public_send(:"#{name}?")

            memo[json_name(name)] = public_send(name).as_json(options)
          end
        end

        def to_json(state = nil)
          raise SBOM::CycloneDX::Error, "Record is not valid" unless valid?

          # RBS is a niusance with this method
          state ? as_json.to_json(state) : as_json.to_json
        end

        def formatted_errors
          errors.map { |k, v| "#{k}: #{v.join(", ")}" }.join("\n")
        end

        private

        def populate_fields(**args)
          args.each do |name, value|
            raise ArgumentError, "Unknown property: #{name}" unless self.class.fields.key?(name)
            raise ArgumentError, "Attempted to set a constant: #{name}" if self.class.fields.fetch(name).const?

            instance_variable_set(:"@#{name}", value)
          end
        end

        def populate_consts_and_defaults
          self.class.fields.each do |name, field|
            next if instance_variable_defined?(:"@#{name}")

            instance_variable_set(:"@#{name}", field.const) if field.const?
            instance_variable_set(:"@#{name}", field.default) if field.default?
          end
        end

        def json_name(member_name)
          self.class.json_name(member_name)
        end

        def validator_for(name)
          self.class.fields.fetch(name).validator
        end

        def validate_value(name)
          return validator_for(name).validate(public_send(name)) if public_send(:"#{name}?")

          validator_for(name).required? ? [SBOM::CycloneDX::Validator::BaseValidator::MISSING_REQUIRED] : []
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
            [message || "#{props.join(", ")} is invalid"]
          else # rubocop:disable Lint/DuplicateBranch
            []
          end
        end

        class << self
          def custom_validators
            @custom_validators ||= []
          end

          def fields
            @fields ||= {}
          end

          def create(**args)
            # TODO: Coerce requisite types
            new(**args)
          end

          def create!(**args)
            create(**args).tap do |instance|
              raise SBOM::CycloneDX::Error, instance.formatted_errors unless instance.valid?
            end
          end

          def json_create(object)
            # TODO: Transform and symbolize keys
            create(**object)
          end

          def json_name(member_name, string_name = nil)
            return json_name_map[member_name] if string_name.nil?

            json_name_map[member_name] = string_name
          end

          def prop(name, type, required: false, **kwargs)
            raise "properties cannot be defined for abstract Record" if self == Record
            raise "properties must be defined in the class body of a subclass of Record" unless in_subclass_body?

            build_prop(name, type, resolve_prop_kwargs(type, **kwargs), required: required)
          end

          def const(name, type, value, required: true, **kwargs)
            prop(name, type, const: value, required: required, **kwargs)
          end

          def validate(*props, presence: nil, message: nil, &block) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength
            raise "custom validators cannot be defined for abstract Record" if self == Record
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

          def prop_names(include_const: false)
            return @fields.keys if include_const

            @fields.reject { |_name, field| field.const? }.keys
          end

          def const_names
            @fields.select { |_name, field| field.const? }.keys
          end

          private

          def in_subclass_body? # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
            caller_location = caller_locations&.find do |location|
              !location.label&.include?("__RBS_TEST") && location.path != __FILE__
            end

            self < Base && (caller_location&.label&.start_with?("<class:") || false)
          end

          def json_name_map
            @json_name_map ||= Hash.new { |h, k| h[k] = k.to_s.camelize(:lower) }
          end

          def build_prop(name, type, field_params, required: false)
            @fields ||= {} #: Hash[Symbol, SBOM::CycloneDX::Field::Base[untyped]]
            @fields[name] = SBOM::CycloneDX::Field.for(type, name, required: required, **field_params)

            unless field_params.to_h.key?(:const)
              define_method(:"#{name}=") { |value| instance_variable_set(:"@#{name}", value) }
            end

            define_method(name) { instance_variable_get(:"@#{name}") }
            define_method(:"#{name}?") { instance_variable_defined?(:"@#{name}") }
            define_method(:"#{name}_valid?") { validate_value(name).empty? }
          end

          def resolve_prop_kwargs(type, **kwargs) # rubocop:disable Metrics/MethodLength,Metrics/CyclomaticComplexity
            case type
            when :array
              kwargs.slice(:items, :unique, :const).compact #$ Validator::arrayValidatorParams
            when :boolean, :date_time, :email_address, :uri
              kwargs.slice(:const).compact #$ { const: untyped }
            when :float, :integer
              kwargs.slice(:minimum, :maximum, :const).compact #$ { minimum: number, maximum: number, const: number }
            when :string
              kwargs.slice(:enum, :max_length, :min_length, :pattern, :const).compact #$ Validator::stringValidatorParams
            when :union
              kwargs.slice(:of, :const).compact #$ Validator::unionValidatorParams
            when Class
              raise "Unknown type: #{type}" unless type < Base

              kwargs.slice(:const).compact #$ Validator::recordValidatorParams[type]
            else
              raise "Unknown type: #{type}"
            end #: Validator::arrayValidatorParams | Validator::booleanValidatorParams | Validator::dateTimeValidatorParams | Validator::emailAddressValidatorParams | Validator::floatValidatorParams | Validator::integerValidatorParams | Validator::stringValidatorParams | Validator::unionValidatorParams | Validator::uriValidatorParams | Validator::recordValidatorParams
          end

          def validate_presence(props, presence, message = nil) # rubocop:disable Metrics/MethodLength
            case presence
            when :all
              [
                props,
                message || "all of #{props.join(", ")} must be present",
                ->(*values) { values.all? }
              ]
            when :any
              [
                props,
                message || "at least one of #{props.join(", ")} must be present",
                ->(*values) { values.any? }
              ]
            when :one
              [
                props,
                message || "exactly one of #{props.join(", ")} must be present",
                ->(*values) { values.one? }
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
