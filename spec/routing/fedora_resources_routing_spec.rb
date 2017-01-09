require "rails_helper"

RSpec.describe FedoraResourcesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fedora_resources").to route_to("fedora_resources#index")
    end

    it "routes to #new" do
      expect(:get => "/fedora_resources/new").to route_to("fedora_resources#new")
    end

    it "routes to #show" do
      expect(:get => "/fedora_resources/1").to route_to("fedora_resources#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/fedora_resources/1/edit").to route_to("fedora_resources#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/fedora_resources").to route_to("fedora_resources#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fedora_resources/1").to route_to("fedora_resources#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fedora_resources/1").to route_to("fedora_resources#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fedora_resources/1").to route_to("fedora_resources#destroy", :id => "1")
    end

  end
end
