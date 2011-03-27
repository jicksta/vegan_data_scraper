module VeganDrinks
  class Fetcher

    BR = /<br\s*\/?>/i

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def page
      @page ||= Mechanize.new.get(@url)
    end

  end
end