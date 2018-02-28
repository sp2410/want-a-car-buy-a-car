require "rails_helper"

RSpec.describe NewDealerContatsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/new_dealer_contats").to route_to("new_dealer_contats#index")
    end

    it "routes to #new" do
      expect(:get => "/new_dealer_contats/new").to route_to("new_dealer_contats#new")
    end

    it "routes to #show" do
      expect(:get => "/new_dealer_contats/1").to route_to("new_dealer_contats#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/new_dealer_contats/1/edit").to route_to("new_dealer_contats#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/new_dealer_contats").to route_to("new_dealer_contats#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/new_dealer_contats/1").to route_to("new_dealer_contats#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/new_dealer_contats/1").to route_to("new_dealer_contats#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/new_dealer_contats/1").to route_to("new_dealer_contats#destroy", :id => "1")
    end

  end
end
