# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mince_migrator/version'

Gem::Specification.new do |gem|
  gem.name          = "mince_migrator"
  gem.version       = MinceMigrator::VERSION
  gem.authors       = ["Matt Simpson"]
  gem.email         = ["matt.simpson3@gmail.com"]
  gem.description   = %q{Mince Migrator is a library that provides a way to run database migrations for your application using the Mince libraries}
  gem.summary       = %q{Provides the ability to write migrations for the mince gems}
  gem.homepage      = "https://github.com/coffeencoke/mince_migrator"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
