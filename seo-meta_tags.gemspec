# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seo/meta_tags/version'

Gem::Specification.new do |spec|
  spec.name          = "seo-meta_tags"
  spec.version       = Seo::MetaTags::VERSION
  spec.authors       = ["Alexandr S"]
  spec.email         = ["alexandr@avaio-media.ru"]
  spec.summary       = %q{Gem for manage meta tags like title, keywords, description}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
