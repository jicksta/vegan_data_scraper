module VeganDrinks
  class Listing < Fetcher

    def initialize(list_name)
      @start_url = "#{BASE_URL}/#{list_name}"
      @list_name = list_name
    end

    def load!
      agent = Mechanize.new
      info "Loading listing for the #{@list_name} section"
      start_listing = agent.get(@start_url)

      section_link_list = start_listing.search(".filter ul:contains('By Letter')").first
      section_links = start_listing.links.find_all do |link|
        link.node.ancestors.include? section_link_list
      end
      debug "Found #{@list_name} sections #{section_links.map(&:text).join(', ')}"
      @companies = section_links.map do |section_link|
        debug "Loading listing page #{section_link.text}"
        listing_page = section_link.click
        product_list_node = listing_page.search("h1:contains('Listing')").first.next_element

        product_links = listing_page.links.find_all do |link|
          link.node.ancestors.include? product_list_node
        end

        debug "Found #{product_links.size} companies"

        product_links.map do |link|
          debug "Loading page for #{link.text} at url #{link.href}"
          product_page = link.click
          VeganDrinks::DetailsPage.new(product_page)
        end.compact
      end.flatten
    end

    def companies
      @companies || load!
    end

  end
end