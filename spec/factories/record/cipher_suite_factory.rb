# frozen_string_literal: true

require "yaml"

FactoryBot.define do
  factory :cipher_suite, parent: :record, class: "SBOM::CycloneDX::Record::CipherSuite" do
    transient do
      cipher_data { @cipher_data ||= YAML.load_file("spec/fixtures/cipher_info.yml") }
    end

    trait :all_fields do
      name { cipher_data.keys.sample }
      identifiers { cipher_data[name] }
      algorithms do
        name.split("_")[0..-2].each_with_object([]) do |word, memo|
          case word
          when "WITH", "TLS", "NULL" then next
          when /\A[0-9]+\z/ then memo << "#{memo.pop}-#{word}"
          when /\A[A-Z]+[0-9]{2,}\z/ then memo << word.gsub(/([A-Z])([0-9])/, '\1-\2').downcase
          else memo << word.downcase
          end
        end
      end
    end
  end
end
