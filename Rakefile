require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :bench

desc "Runs exe/matrix_dot_bench"
task :bench do
  sh 'bundle exec exe/matrix_dot_bench'
end
