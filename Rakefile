require 'rake'
require 'rake/testtask'
require 'shoulda'

test_files_pattern = 'test/**/*_test.rb'
Rake::TestTask.new do |t|
  t.pattern = test_files_pattern
  t.verbose = true
end

task :default => 'test'
