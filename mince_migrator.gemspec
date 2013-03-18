# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'mince_migrator/version'

Gem::Specification.new do |s|
  s.name        = "mince_migrator"
  s.version     = MinceMigrator.version
  s.authors     = ["Matt Simpson"]
  s.email       = ["matt@railsgrammer.com"]
  s.homepage    = "https://github.com/coffeencoke/#{s.name}"
  s.summary     = %q{Manages migrations for Mince gems}
  s.description = %q{Provides the ability to write migrations for the mince gems}

  s.rubyforge_project = s.name
  s.has_rdoc = true

  s.files         = %w(
    bin/mince_migrator
    lib/mince_mibrator.rb
    lib/mince_migrator/version.rb
    lib/mince_migrator/creator.rb
    lib/mince_migrator/migration_file.rb
    lib/mince_migrator/migration_template.rb
    lib/mince_migrator/templates/migration_template.mustache
  )

  s.test_files    = %w(
    spec/integration/create_a_migration_spec.rb
    spec/integration/list_all_migrations_spec.rb
    spec/units/mince_migrator/creator_spec.rb
    spec/units/mince_migrator/migration_file_spec.rb
    spec/units/mince_migrator/migration_template_spec.rb

  )
  s.require_paths = ["lib"]
  s.bindir = 'bin'
  s.executables << 'mince_migrator'

  s.required_ruby_version = "~> 1.9.3"
  s.add_runtime_dependency "mince", "~> 2.0"
  s.add_runtime_dependency "gli", "~> 2.5"
  s.add_runtime_dependency "mustache", "0.99.4"
  s.add_runtime_dependency "command_line_reporter", '~> 3.2'
  s.add_development_dependency "rake", '~> 0.9'
  s.add_development_dependency "rspec", '~> 2.0'
  s.add_development_dependency "guard-rspec", '~> 0.6'
  s.add_development_dependency "yard", "~> 0.7"
  s.add_development_dependency "redcarpet", "~> 2.1"
  s.add_development_dependency "debugger", "~> 1.2"
  s.add_development_dependency "rb-fsevent", "~> 0.9.0"
  s.add_development_dependency "hashy_db", "~> 2.0"
end

