# frozen_string_literal: true

require_relative "lib/sbom/cyclone_dx/version"

Gem::Specification.new do |spec|
  spec.name = "sbom-cyclonedx"
  spec.version = SBOM::CycloneDX::VERSION
  spec.authors = ["Rob Trame"]
  spec.email = ["rtrame@hackerone.com"]

  spec.summary = "Gem for generating/parsing CycloneDX JSON SBOMs"
  spec.description = "Gem for generating/parsing CycloneDX JSON SBOMs"
  spec.homepage = "https://github.com/Hacker0x01/sbom-cyclonedx"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Hacker0x01/sbom-cyclonedx"
  spec.metadata["changelog_uri"] = "https://github.com/Hacker0x01/sbom-cyclonedx/blob/main/CHANGELOG.md"

  spec.files = `git ls-files`.split("\n")
  spec.bindir = "bin"
  spec.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 6.1", "< 8"
  spec.add_dependency "email_address", "~> 0.2", ">= 0.2.4"
  spec.metadata["rubygems_mfa_required"] = "true"
end
