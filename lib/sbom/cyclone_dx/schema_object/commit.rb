# frozen_string_literal: true
# rbs_inline: enabled

# Commit - Specifies an individual commit
module SBOM
  module CycloneDX
    Commit = SchemaObject.build("Commit") do
      # UID - A unique identifier of the commit. This may be version control specific. For example, Subversion uses revision numbers whereas git uses commit hashes.
      prop :uid, String

      # URL - The URL to the commit. This URL will typically point to a commit in a version control system.
      prop :url, URI

      # Author - The author who created the changes in the commit
      prop :author, IdentifiableAction

      # Committer - The person who committed or pushed the commit
      prop :committer, IdentifiableAction

      # Message - The text description of the contents of the commit
      prop :message, String
    end
  end
end
