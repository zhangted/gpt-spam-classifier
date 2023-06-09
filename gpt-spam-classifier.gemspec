# frozen_string_literal: true

require_relative "lib/gpt/spam/classifier/version"

Gem::Specification.new do |spec|
  spec.name = "gpt-spam-classifier"
  spec.version = Gpt::Spam::Classifier::VERSION
  spec.authors = ["Teddy Zhang"]
  spec.email = ["tedcbook@gmail.com"]
  spec.version       = "0.1.0"
  spec.summary       = "Configure open ai gpt to simulate JSON spam classifier"
  spec.description   = "Configure open ai gpt to simulate JSON spam classifier"
  spec.homepage      = "https://example.com/my_gem"
  spec.license       = "MIT"
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
