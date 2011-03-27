require 'bundler'
Bundler.require :test
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.rspec_opts = ["--format", "documentation", "--color"]
end

task :default => :spec
