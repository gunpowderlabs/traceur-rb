# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'traceur/version'

Gem::Specification.new do |spec|
  spec.name          = "traceur-rb"
  spec.version       = Traceur::Rb::VERSION
  spec.authors       = ["Adam Pohorecki"]
  spec.email         = ["adam@pohorecki.pl"]
  spec.summary       = %q{Ruby wrapper for Google Traceur.}
  spec.description   = %q{Wraps Google Traceur, so that it can be invoked from any Ruby application.}
  spec.homepage      = "https://github.com/psyho/traceur-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
