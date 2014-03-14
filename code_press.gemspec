# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'code_press/version'

Gem::Specification.new do |spec|
  spec.name          = 'code_press'
  spec.version       = CodePress::VERSION
  spec.authors       = ['Benjamin Cavileer']
  spec.email         = ['bcavileer@holmanauto.com']
  spec.summary       = %q{Manages maintaining tarballs and tags to a Git Repository}
  spec.description   = %q{Extracts tarballs, commits changes, and tags with version.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'git'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry-plus'
end
