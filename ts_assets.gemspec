# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ts_assets/version"

Gem::Specification.new do |spec|
  spec.name          = "ts_assets"
  spec.version       = TsAssets::VERSION
  spec.authors       = ["Kenju Wagatsuma"]
  spec.email         = ["ken901waga@gmail.com"]

  spec.summary       = %q{Exports Rails assets to TypeScript as React components}
  spec.description   = %q{The gem exports Rails assets to TypeScript as React components.}
  spec.homepage      = "https://github.com/bitjourney/ts_assets-rails"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|__tests__)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 5.0"
  spec.add_runtime_dependency 'fastimage', ">= 2.1"
  spec.add_runtime_dependency 'sprockets', ">= 3.7"
end
