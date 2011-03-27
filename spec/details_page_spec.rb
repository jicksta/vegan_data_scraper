# encoding: UTF-8
require 'spec_helper'

describe VeganDrinks::DetailsPage do

  it_behaves_like "a fetcher class"
  
  describe "integration tests with the site HTML" do

    describe "For a normal vegan brewery, Abbaye des Rocs" do

      let(:normal_vegan_brewery) do
        url = "http://barnivore.com/beer/938/Abbaye-des-Rocs"
        VCR.use_cassette('normal_vegan_brewery', :record => :new_episodes) do
          VeganDrinks::DetailsPage.new(url).tap(&:page)
        end
      end

      specify "#name" do
        normal_vegan_brewery.company_name.should == "Abbaye des Rocs"
      end

      specify "#address" do
        address = normal_vegan_brewery.address
        address.should == ["37, Chaussée Brunehault", "7387 Montignies-sur-Roc", "Belgium"]
      end

      specify "#phone_number" do
        normal_vegan_brewery.phone_number.should == "+32 65 75 59 99"
      end

      specify "#fax_number" do
        normal_vegan_brewery.fax_number.should == "+32 65 75 59 98"
      end

      specify "#contact_email" do
        normal_vegan_brewery.contact_email.should == "abbaye.des.rocs@skynet.be"
      end

      specify "#url" do
        normal_vegan_brewery.url.should == "http://www.abbaye-des-rocs.com/page%20en%20anglais.htm"
      end

      specify "#first_checker_name" do
        normal_vegan_brewery.first_checker_name.should == "Eric"
      end

      specify "#double_checker_name" do
        normal_vegan_brewery.double_checker_name.should == :nobody
      end

      specify "#company_email" do
        normal_vegan_brewery.company_email.should == %("We don't use any animal product in the clarification of our beer ")
      end

      specify "#date_added" do
        normal_vegan_brewery.date_added.should == "about 1 year ago"
      end
      specify "#date_updated" do
        normal_vegan_brewery.date_updated.should be_nil
      end

      describe "#products" do
        it "should return an OrderedHash object" do
          normal_vegan_brewery.products.should_not be_empty
          normal_vegan_brewery.products.should be_kind_of ActiveSupport::OrderedHash
        end

        it "should properly parse the name of the products" do
          normal_vegan_brewery.products.keys.should == ["Abbaye des Rocs", "Blanche des Honnelles", "Montignies-sur-Roc"]
        end

        it "should properly parse the veganosity of the products" do
          normal_vegan_brewery.products.values.should == [true] * 3
        end

      end
    end

    describe "For a brewery with a some non-vegan options, 21st Amendment" do

      let(:some_non_vegan_options_brewery) do
        url = "http://barnivore.com/beer/742/21st-Amendment-Brewery"
        VCR.use_cassette('some_non_vegan_options_brewery', :record => :new_episodes) do
          VeganDrinks::DetailsPage.new(url).tap(&:page)
        end
      end

      specify "#date_added" do
        some_non_vegan_options_brewery.date_added.should == "almost 2 years ago"
      end

      specify "#date_updated" do
        some_non_vegan_options_brewery.date_updated.should == "about 1 year ago"
      end

      describe "#products" do
        it "should have a non-vegan option" do
          products = some_non_vegan_options_brewery.products
          products.should_not be_empty
          non_vegan_option_name, veganosity = products.rassoc(false)
          non_vegan_option_name.should == "Oyster Point Oyster Stout"
        end
      end

    end

  end


end