require 'spec_helper'

describe VeganDrinks::Listing do

  let :beer_listing do
    VCR.use_cassette('beer_listings', :record => :new_episodes) do
      VeganDrinks::Listing.new(:beer).tap(&:companies)
    end
  end

  describe "#companies" do
    describe "for beer" do
      it "should return an array of DetailPages" do
        beer_listing.companies.should_not be_empty
        beer_listing.companies.each do |page|
          page.should be_kind_of VeganDrinks::DetailsPage
        end
      end

      it "should contain companies in all of the sections" do
        url_segments = beer_listing.companies.map do |company|
          company.url[%r{/([^/]+)$}, 1]
        end

        default_sections = ['0'..'9', 'A'..'F', 'G'..'L', 'M'..'R', 'S'..'T', 'U'..'Z']
        default_sections.each do |section|
          section.should be_any { |character|
            url_segments.any? do |segment|
              segment.upcase.starts_with? character
            end
          }
        end
      end

    end
  end

end