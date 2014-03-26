require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PageRatesController do

  # This should return the minimal set of attributes required to create a valid
  # PageRate. As you add validations to PageRate, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "page" => "" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PageRatesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all page_rates as @page_rates" do
      page_rate = PageRate.create! valid_attributes
      get :index, {}, valid_session
      assigns(:page_rates).should eq([page_rate])
    end
  end

  describe "GET show" do
    it "assigns the requested page_rate as @page_rate" do
      page_rate = PageRate.create! valid_attributes
      get :show, {:id => page_rate.to_param}, valid_session
      assigns(:page_rate).should eq(page_rate)
    end
  end

  describe "GET new" do
    it "assigns a new page_rate as @page_rate" do
      get :new, {}, valid_session
      assigns(:page_rate).should be_a_new(PageRate)
    end
  end

  describe "GET edit" do
    it "assigns the requested page_rate as @page_rate" do
      page_rate = PageRate.create! valid_attributes
      get :edit, {:id => page_rate.to_param}, valid_session
      assigns(:page_rate).should eq(page_rate)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new PageRate" do
        expect {
          post :create, {:page_rate => valid_attributes}, valid_session
        }.to change(PageRate, :count).by(1)
      end

      it "assigns a newly created page_rate as @page_rate" do
        post :create, {:page_rate => valid_attributes}, valid_session
        assigns(:page_rate).should be_a(PageRate)
        assigns(:page_rate).should be_persisted
      end

      it "redirects to the created page_rate" do
        post :create, {:page_rate => valid_attributes}, valid_session
        response.should redirect_to(PageRate.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved page_rate as @page_rate" do
        # Trigger the behavior that occurs when invalid params are submitted
        PageRate.any_instance.stub(:save).and_return(false)
        post :create, {:page_rate => { "page" => "invalid value" }}, valid_session
        assigns(:page_rate).should be_a_new(PageRate)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        PageRate.any_instance.stub(:save).and_return(false)
        post :create, {:page_rate => { "page" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested page_rate" do
        page_rate = PageRate.create! valid_attributes
        # Assuming there are no other page_rates in the database, this
        # specifies that the PageRate created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        PageRate.any_instance.should_receive(:update).with({ "page" => "" })
        put :update, {:id => page_rate.to_param, :page_rate => { "page" => "" }}, valid_session
      end

      it "assigns the requested page_rate as @page_rate" do
        page_rate = PageRate.create! valid_attributes
        put :update, {:id => page_rate.to_param, :page_rate => valid_attributes}, valid_session
        assigns(:page_rate).should eq(page_rate)
      end

      it "redirects to the page_rate" do
        page_rate = PageRate.create! valid_attributes
        put :update, {:id => page_rate.to_param, :page_rate => valid_attributes}, valid_session
        response.should redirect_to(page_rate)
      end
    end

    describe "with invalid params" do
      it "assigns the page_rate as @page_rate" do
        page_rate = PageRate.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        PageRate.any_instance.stub(:save).and_return(false)
        put :update, {:id => page_rate.to_param, :page_rate => { "page" => "invalid value" }}, valid_session
        assigns(:page_rate).should eq(page_rate)
      end

      it "re-renders the 'edit' template" do
        page_rate = PageRate.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        PageRate.any_instance.stub(:save).and_return(false)
        put :update, {:id => page_rate.to_param, :page_rate => { "page" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested page_rate" do
      page_rate = PageRate.create! valid_attributes
      expect {
        delete :destroy, {:id => page_rate.to_param}, valid_session
      }.to change(PageRate, :count).by(-1)
    end

    it "redirects to the page_rates list" do
      page_rate = PageRate.create! valid_attributes
      delete :destroy, {:id => page_rate.to_param}, valid_session
      response.should redirect_to(page_rates_url)
    end
  end

end
