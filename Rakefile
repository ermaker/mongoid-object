begin
  require 'bundler/gem_tasks'
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
  namespace :rubocop do
    desc "Run 'rubocop --auto-gen-config'"
    task :todo do
      sh 'rubocop --auto-gen-config'
    end
  end
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

begin
  require 'rubycritic/rake_task'
  Rubycritic::RakeTask.new do |task|
    task.paths = FileList['**/*.rb'] \
      - FileList['spec/**/*_spec.rb'] \
      - FileList['lib/**/cli.rb']
    task.options = '--no-browser'
  end
rescue LoadError # rubocop:disable Lint/HandleExceptions
end
