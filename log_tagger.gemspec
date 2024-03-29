# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'log_tagger/version'

Gem::Specification.new do |spec|
  spec.name          = "log_tagger"
  spec.version       = LogTagger::VERSION
  spec.authors       = ["Federico Dayan"]
  spec.email         = ["federico.dayan@gmail.com"]
  spec.summary       = %q{Filter log entries using regex}
  spec.description   = %q{Filter log entries using regex}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency  "rainbow"
  spec.add_dependency  "slop"
end
