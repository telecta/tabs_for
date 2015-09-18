# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tabs_for/version'

Gem::Specification.new do |spec|
  spec.name          = "tabs_for"
  spec.version       = TabsFor::VERSION
  spec.authors       = ["Ole J. Rosendahl"]
  spec.email         = ["ole.johnny.rosendahl@gmail.com"]

  spec.summary       = "ActiveView Helper for creating tabs with Bootstrap."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/blacktangent/tabs_for"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency "rails", ">= 3.2", "< 5.0"

  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "sqlite3"
end
