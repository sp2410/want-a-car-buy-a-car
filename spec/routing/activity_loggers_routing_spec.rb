require "rails_helper"

RSpec.describe ActivityLoggersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/activity_loggers").to route_to("activity_loggers#index")
    end

    it "routes to #new" do
      expect(:get => "/activity_loggers/new").to route_to("activity_loggers#new")
    end

    it "routes to #show" do
      expect(:get => "/activity_loggers/1").to route_to("activity_loggers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/activity_loggers/1/edit").to route_to("activity_loggers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/activity_loggers").to route_to("activity_loggers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/activity_loggers/1").to route_to("activity_loggers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/activity_loggers/1").to route_to("activity_loggers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/activity_loggers/1").to route_to("activity_loggers#destroy", :id => "1")
    end

  end
end
