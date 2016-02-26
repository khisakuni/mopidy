# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mopidy/version'

Gem::Specification.new do |spec|
  spec.name          = 'mopidy'
  spec.version       = Mopidy::VERSION
  spec.authors       = ['khisakuni']
  spec.email         = ['kohei@gophilosophie.com']

  spec.summary       = 'A wrapper around the Mopidy API.'
  spec.homepage      = 'https://github.com/khisakuni/mopidy'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.13.7'

  spec.add_development_dependency 'bundle', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', "~> 3.0"
  spec.add_development_dependency 'pry'
end
