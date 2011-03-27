require 'rspec'
require 'vcr'
require 'webmock/rspec'

require File.dirname(__FILE__) + "/../lib/vegan_drinks"

VCR.config do |c|
  c.cassette_library_dir = File.dirname(__FILE__) + '/fixtures/vcr_cassettes'
  c.stub_with :webmock
end

RSpec.configure do |rspec|
  rspec.before :suite do
    VeganDrinks.logger.level = Logger::WARN
  end
end