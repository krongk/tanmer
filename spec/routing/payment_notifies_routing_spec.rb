require "spec_helper"

describe PaymentNotifiesController do
  describe "routing" do

    it "routes to #index" do
      get("/payment_notifies").should route_to("payment_notifies#index")
    end

    it "routes to #new" do
      get("/payment_notifies/new").should route_to("payment_notifies#new")
    end

    it "routes to #show" do
      get("/payment_notifies/1").should route_to("payment_notifies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/payment_notifies/1/edit").should route_to("payment_notifies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/payment_notifies").should route_to("payment_notifies#create")
    end

    it "routes to #update" do
      put("/payment_notifies/1").should route_to("payment_notifies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/payment_notifies/1").should route_to("payment_notifies#destroy", :id => "1")
    end

  end
end
