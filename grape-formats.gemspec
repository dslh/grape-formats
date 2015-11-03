$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'grape/formats/version'

Gem::Specification.new do |s|
  s.name        = 'grape-formats'
  s.version     = Grape::Formats::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Doug Hammond']
  s.email       = ['d.lakehammond@gmail.com']
  s.summary     = 'Extended format parsing and type validation for Grape.'
  s.description =
    'Provides a number of validators for various parameter types and formats.'
  s.license     = 'MIT'

  s.add_runtime_dependency 'grape', '>= 0.13.1'
  s.add_runtime_dependency 'virtus', '>= 1.0.0'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-rubocop'
  s.add_development_dependency 'guard-yard'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'yard'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']
end
