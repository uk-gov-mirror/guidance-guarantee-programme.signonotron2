# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('config/application', __dir__)

require_relative 'lib/volatile_lock'
include VolatileLock::DSL

Signonotron2::Application.load_tasks

default_tasks = %i[test spec check_for_bad_time_handling]

begin
  # Rubocop is not available in envs other than development and test.
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
  default_tasks.unshift(:rubocop)
rescue LoadError
end

task default: default_tasks
