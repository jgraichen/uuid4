# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uuid4/version'

Gem::Specification.new do |spec|
  spec.name          = 'uuid4'
  spec.version       = UUID4::VERSION
  spec.authors       = ['Jan Graichen']
  spec.email         = ['jg@altimos.de']

  spec.summary       = %q{A UUIDv4 support library}
  spec.homepage      = 'https://github.com/jgraichen/uuid4'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.add_runtime_dependency 'base62-rb', '~> 0.3.0'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
