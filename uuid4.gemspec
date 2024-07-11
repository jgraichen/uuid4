# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uuid4/version'

Gem::Specification.new do |spec|
  spec.name          = 'uuid4'
  spec.version       = UUID4::VERSION
  spec.authors       = ['Jan Graichen']
  spec.email         = ['jg@altimos.de']

  spec.summary       = 'A UUIDv4 support library'
  spec.homepage      = 'https://github.com/jgraichen/uuid4'
  spec.license       = 'MIT'

  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.required_ruby_version = '>= 2.7.0'

  spec.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_dependency 'base62-rb', '~> 0.3.0'
end
