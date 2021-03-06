# frozen_string_literal: true

require_relative "lib/rubocop/temporal/version"

Gem::Specification.new do |spec|
  spec.name = "rubocop-temporal"
  spec.version = RuboCop::Temporal::VERSION
  spec.authors = ["Achilleas Buisman"]
  spec.email = ["temporal@abuisman.nl"]

  spec.summary = "Rubocop cop that makes sure travel_to is called with a block"
  spec.description = "A rubocop cop that check that `travel_to` is only called with a block."
  spec.homepage = "https://github.com/abuisman/rubocop-temporal"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/abuisman/rubocop-temporal"
  spec.metadata["changelog_uri"] = "https://github.com/abuisman/rubocop-temporal"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rubocop", "~> 1.8"
end
