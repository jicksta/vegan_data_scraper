require 'rspec'
require 'vcr'
require 'webmock/rspec'

require File.dirname(__FILE__) + "/../lib/vegan_drinks"

VCR.config do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.stub_with :webmock
end

shared_examples_for "a fetcher class" do

  it "should not do a web request when instantiating with a URL" do
    described_class.new("http://example.com")
    WebMock.should have_not_been_made
  end

  describe "a newly created object" do
    it "should lazily fetch the page" do
      url = "http://example.com/beer"
      stub_request :get, url
      obj = described_class.new(url)
      WebMock.should_not have_requested(:get, url)
      obj.page
      WebMock.should have_requested(:get, url)
    end
  end
end