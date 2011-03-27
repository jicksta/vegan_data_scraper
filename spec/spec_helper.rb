require 'rspec'
require 'vcr'

require File.dirname(__FILE__) + "/../lib/vegan_drinks"

VCR.config do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.stub_with :webmock
end
