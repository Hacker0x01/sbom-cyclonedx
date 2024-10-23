# frozen_string_literal: true

D = Steep::Diagnostic

target :lib do
  signature "sig"
  check "lib" # Directory name
  library "email_address"

  if ENV.fetch("CI", "false") == "true"
    repo_path "vendor/rbs"
    repo_path "vendor/ruby"
  end
end
