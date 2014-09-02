require "spec_helper"

describe PageImagesController do
  describe "routing" do

    it "routes to #index" do
      get("/page_images").should route_to("page_images#index")
    end

    it "routes to #new" do
      get("/page_images/new").should route_to("page_images#new")
    end

    it "routes to #show" do
      get("/page_images/1").should route_to("page_images#show", :id => "1")
    end

    it "routes to #edit" do
      get("/page_images/1/edit").should route_to("page_images#edit", :id => "1")
    end

    it "routes to #create" do
      post("/page_images").should route_to("page_images#create")
    end

    it "routes to #update" do
      put("/page_images/1").should route_to("page_images#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/page_images/1").should route_to("page_images#destroy", :id => "1")
    end

  end
end
