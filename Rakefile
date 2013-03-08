require 'bundler/gem_tasks'
require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec:integration') do |spec|
  spec.pattern = 'spec/integration/**/*_spec.rb'
  spec.rspec_opts = ['--backtrace']
  # spec.ruby_opts = ['-w']
end

RSpec::Core::RakeTask.new('spec:units') do |spec|
  spec.pattern = 'spec/units/**/*_spec.rb'
  spec.rspec_opts = ['--backtrace']
  # spec.ruby_opts = ['-w']
end

task :default => ['spec:integration', 'spec:units']

