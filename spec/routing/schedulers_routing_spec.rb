require "rails_helper"

RSpec.describe SchedulersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/schedulers").to route_to("schedulers#index")
    end

    it "routes to #new" do
      expect(:get => "/schedulers/new").to route_to("schedulers#new")
    end

    it "routes to #show" do
      expect(:get => "/schedulers/1").to route_to("schedulers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/schedulers/1/edit").to route_to("schedulers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/schedulers").to route_to("schedulers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/schedulers/1").to route_to("schedulers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/schedulers/1").to route_to("schedulers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/schedulers/1").to route_to("schedulers#destroy", :id => "1")
    end

  end
end
