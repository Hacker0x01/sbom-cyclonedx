# frozen_string_literal: true

require_relative "../schema_object"
require_relative "identifiable_action"

# Commit - Specifies an individual commit
module SBOM
  module CycloneDX
    class Commit < Struct.new(
      "Commit",
      # UID - A unique identifier of the commit. This may be version control specific. For example, Subversion uses revision numbers whereas git uses commit hashes.
      :uid,
      # URL - The URL to the commit. This URL will typically point to a commit in a version control system.
      :url,
      # Author - The author who created the changes in the commit
      :author,
      # Committer - The person who committed or pushed the commit
      :committer,
      # Message - The text description of the contents of the commit
      :message,
      keyword_init: true
    )
      include SchemaObject

      def valid?
        Validator.valid?(String, uid) &&
          Validator.valid?(URI, url) &&
          Validator.valid?(IdentifiableAction, author) &&
          Validator.valid?(IdentifiableAction, committer) &&
          Validator.valid?(String, message)
      end
    end
  end
end
