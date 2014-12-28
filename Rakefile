require 'data_mapper'
require './app/data_mapper_setup'
require 'rspec/core/rake_task'

task :auto_upgrade do
  DataMapper.auto_upgrade!
  puts "Auto-upgrade complete (no data loss)"
end

task :auto_migrate do
  DataMapper.auto_migrate!
  puts "Auto-migrate complete (data could have been lost)"
end

RSpec::Core::RakeTask.new(:spec)
task :default => :spec
