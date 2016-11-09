require "rake/testtask"
require "ci/reporter/rake/minitest"

Rake::TestTask.new(:test) do |task|
  task.libs = ["test",
               "lib"]

  task.pattern = "**/*_test.rb"
end

task :ci => ['ci:setup:minitest', 'test']
