# frozen_string_literal: true
# rbs_inline: enabled

# Commit - Specifies an individual commit
module Sbom
  module Cyclonedx
    class Commit < SchemaObject
      # UID - A unique identifier of the commit. This may be version control specific. For example, Subversion uses revision numbers whereas git uses commit hashes.
      attr_accessor :uid #: String

      # URL - The URL to the commit. This URL will typically point to a commit in a version control system.
      attr_accessor :url #: URI

      # Author - The author who created the changes in the commit
      attr_accessor :author #: IdentifiableAction

      # Committer - The person who committed or pushed the commit
      attr_accessor :committer #: IdentifiableAction

      # Message - The text description of the contents of the commit
      attr_accessor :message #: String
    end
  end
end
