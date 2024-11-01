# frozen_string_literal: true

require_relative "lib/sbom/cyclone_dx/version"

Gem::Specification.new do |spec|
  spec.name = "sbom-cyclone_dx"
  spec.version = SBOM::CycloneDX::VERSION
  spec.authors = ["Rob Trame"]
  spec.email = ["rtrame@hackerone.com"]

  spec.summary = "Gem for generating/parsing CycloneDX JSON SBOMs"
  spec.description = "Gem for generating/parsing CycloneDX JSON SBOMs"
  spec.homepage = "https://hackerone.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = []
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 7.2", ">= 7.2.1"
  spec.add_dependency "email_address", "~> 0.2", ">= 0.2.4"
  spec.metadata["rubygems_mfa_required"] = "true"
end
