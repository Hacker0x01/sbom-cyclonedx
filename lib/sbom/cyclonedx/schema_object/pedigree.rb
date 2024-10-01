# frozen_string_literal: true
# rbs_inline: enabled

# Component Pedigree - Component pedigree is a way to document complex supply chain scenarios where components are created, distributed, modified, redistributed, combined with other components, etc. Pedigree supports viewing this complex chain from the beginning, the end, or anywhere in the middle. It also provides a way to document variants where the exact relation may not be known.
module SBOM
  module Cyclonedx
    class Pedigree < SchemaObject
      # Ancestors - Describes zero or more components in which a component is derived from. This is commonly used to describe forks from existing projects where the forked version contains a ancestor node containing the original component it was forked from. For example, Component A is the original component. Component B is the component being used and documented in the BOM. However, Component B contains a pedigree node with a single ancestor documenting Component A - the original component from which Component B is derived from.
      attr_accessor :ancestors #: [Component]

      # Descendants - Descendants are the exact opposite of ancestors. This provides a way to document all forks (and their forks) of an original or root component.
      attr_accessor :descendants #: [Component]

      # Variants - Variants describe relations where the relationship between the components is not known. For example, if Component A contains nearly identical code to Component B. They are both related, but it is unclear if one is derived from the other, or if they share a common ancestor.
      attr_accessor :variants #: [Component]

      # Commits - A list of zero or more commits which provide a trail describing how the component deviates from an ancestor, descendant, or variant.
      attr_accessor :commits #: [Commit]

      # Patches - A list of zero or more patches describing how the component deviates from an ancestor, descendant, or variant. Patches may be complementary to commits or may be used in place of commits.
      attr_accessor :patches #: [Patch]

      # Notes - Notes, observations, and other non-structured commentary describing the components pedigree.
      attr_accessor :notes #: String

      default :patches, [false]
    end
  end
end
