require "spec_helper"

describe PageRatesController do
  describe "routing" do

    it "routes to #index" do
      get("/page_rates").should route_to("page_rates#index")
    end

    it "routes to #new" do
      get("/page_rates/new").should route_to("page_rates#new")
    end

    it "routes to #show" do
      get("/page_rates/1").should route_to("page_rates#show", :id => "1")
    end

    it "routes to #edit" do
      get("/page_rates/1/edit").should route_to("page_rates#edit", :id => "1")
    end

    it "routes to #create" do
      post("/page_rates").should route_to("page_rates#create")
    end

    it "routes to #update" do
      put("/page_rates/1").should route_to("page_rates#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/page_rates/1").should route_to("page_rates#destroy", :id => "1")
    end

  end
end
