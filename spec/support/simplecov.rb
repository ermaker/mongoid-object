require 'simplecov'
if ENV['CI']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
SimpleCov.start
