# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'populus/version'

Gem::Specification.new do |spec|
  spec.name          = "populus"
  spec.version       = Populus::VERSION
  spec.authors       = ["Uchio, KONDO"]
  spec.email         = ["udzura@udzura.jp"]
  spec.summary       = %q{Consul event definition DSL}
  spec.description   = %q{Consul event definition DSL}
  spec.homepage      = "https://github.com/udzura/populus"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "specinfra"
  spec.add_dependency "colorize"
  spec.add_dependency "slack-notifier"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "power_assert"
  spec.add_development_dependency "test-unit", ">= 3"
  spec.add_development_dependency "test-unit-rr"
end
