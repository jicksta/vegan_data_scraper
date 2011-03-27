require 'rubygems'
require 'ap'
require 'mechanize'

agent = Mechanize.new

main_beer_listing_page = agent.get "http://barnivore.com/beer"

beer_listing_page_links = main_beer_listing_page.links_with(:text => /^\s*\w\s*-\s*\w\s*$/i)

beer_listing_page_links.each do |link|
  page = link.click
  company_list = page.search("#content ul").last
  company_list_links = company_list.links
  company_list_links.each do |company_list_link|
    company_page = company_list_link.click
    content = company_page.search("#content")
    company_heading
  end
end
