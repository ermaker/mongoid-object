# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/object/version'

Gem::Specification.new do |spec|
  spec.name          = 'mongoid-object'
  spec.version       = Mongoid::Object::VERSION
  spec.authors       = ['Minwoo Lee']
  spec.email         = ['ermaker@gmail.com']

  spec.summary       = 'mongoid-object'
  spec.description   = 'mongoid-object'
  spec.homepage      = 'http://github.com/ermaker/mongoid-object'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'mongoid'
  spec.add_dependency 'oj'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'guard-rubycritic'
  spec.add_development_dependency 'guard-fasterer'
  spec.add_development_dependency 'guard-shell'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubycritic'
  spec.add_development_dependency 'fasterer'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'codecov'
  spec.add_development_dependency 'database_cleaner'
end
