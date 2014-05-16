ENV['RAILS_ENV'] ||= 'test'
puts "Loading Rails..."
require "#{ROOT}/config/environment"
require 'rspec/rails'

