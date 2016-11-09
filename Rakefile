require 'rake'
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'

RSpec::Core::RakeTask.new(:test) do |task|
  task.pattern = "spec/**/*_spec.rb"
end

task :ci => ['ci:setup:rspec', 'test']
