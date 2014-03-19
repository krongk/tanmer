require "spec_helper"

describe KeystoresController do
  describe "routing" do

    it "routes to #index" do
      get("/keystores").should route_to("keystores#index")
    end

    it "routes to #new" do
      get("/keystores/new").should route_to("keystores#new")
    end

    it "routes to #show" do
      get("/keystores/1").should route_to("keystores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/keystores/1/edit").should route_to("keystores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/keystores").should route_to("keystores#create")
    end

    it "routes to #update" do
      put("/keystores/1").should route_to("keystores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/keystores/1").should route_to("keystores#destroy", :id => "1")
    end

  end
end
