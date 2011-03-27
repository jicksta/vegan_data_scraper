require 'logger'
require 'active_support/all'

module VeganDrinks

  VERSION_DATA = [0, 9, 0, "pre"]
  VERSION = VERSION_DATA.join "."

  BASE_URL = "http://barnivore.com"

  def self.logger
    @@logger ||= Logger.new(STDOUT).tap do |log|
      log.level = Logger::DEBUG
    end
  end

end

require File.dirname(__FILE__) + "/vegan_drinks/fetcher"
require File.dirname(__FILE__) + "/vegan_drinks/details_page"
require File.dirname(__FILE__) + "/vegan_drinks/listing"