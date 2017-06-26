# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "naver/sdk/version"

Gem::Specification.new do |spec|
  spec.name          = "naver-sdk"
  spec.version       = Naver::Sdk::VERSION
  spec.authors       = ["Surim Kim"]
  spec.email         = ["kimsuelim@gmail.com"]

  spec.summary       = "NAVER SDK for Ruby"
  spec.description   = "The unofficial NAVER SDK for Ruby. Provides both resource oriented interfaces and API clients for NAVER services."
  spec.homepage      = "https://github.com/kimsuelim/naver-sdk-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.2.2"

  spec.add_dependency "faraday", [">= 0.8", "< 1.0"]
  spec.add_dependency "oauth2",   "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rubocop",  "~> 0.49.0"
  spec.add_development_dependency "coveralls", "~> 0.8.21"
end
