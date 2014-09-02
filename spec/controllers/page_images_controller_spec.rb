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

describe PageImagesController do

  # This should return the minimal set of attributes required to create a valid
  # PageImage. As you add validations to PageImage, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "page" => "" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PageImagesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all page_images as @page_images" do
      page_image = PageImage.create! valid_attributes
      get :index, {}, valid_session
      assigns(:page_images).should eq([page_image])
    end
  end

  describe "GET show" do
    it "assigns the requested page_image as @page_image" do
      page_image = PageImage.create! valid_attributes
      get :show, {:id => page_image.to_param}, valid_session
      assigns(:page_image).should eq(page_image)
    end
  end

  describe "GET new" do
    it "assigns a new page_image as @page_image" do
      get :new, {}, valid_session
      assigns(:page_image).should be_a_new(PageImage)
    end
  end

  describe "GET edit" do
    it "assigns the requested page_image as @page_image" do
      page_image = PageImage.create! valid_attributes
      get :edit, {:id => page_image.to_param}, valid_session
      assigns(:page_image).should eq(page_image)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new PageImage" do
        expect {
          post :create, {:page_image => valid_attributes}, valid_session
        }.to change(PageImage, :count).by(1)
      end

      it "assigns a newly created page_image as @page_image" do
        post :create, {:page_image => valid_attributes}, valid_session
        assigns(:page_image).should be_a(PageImage)
        assigns(:page_image).should be_persisted
      end

      it "redirects to the created page_image" do
        post :create, {:page_image => valid_attributes}, valid_session
        response.should redirect_to(PageImage.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved page_image as @page_image" do
        # Trigger the behavior that occurs when invalid params are submitted
        PageImage.any_instance.stub(:save).and_return(false)
        post :create, {:page_image => { "page" => "invalid value" }}, valid_session
        assigns(:page_image).should be_a_new(PageImage)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        PageImage.any_instance.stub(:save).and_return(false)
        post :create, {:page_image => { "page" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested page_image" do
        page_image = PageImage.create! valid_attributes
        # Assuming there are no other page_images in the database, this
        # specifies that the PageImage created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        PageImage.any_instance.should_receive(:update).with({ "page" => "" })
        put :update, {:id => page_image.to_param, :page_image => { "page" => "" }}, valid_session
      end

      it "assigns the requested page_image as @page_image" do
        page_image = PageImage.create! valid_attributes
        put :update, {:id => page_image.to_param, :page_image => valid_attributes}, valid_session
        assigns(:page_image).should eq(page_image)
      end

      it "redirects to the page_image" do
        page_image = PageImage.create! valid_attributes
        put :update, {:id => page_image.to_param, :page_image => valid_attributes}, valid_session
        response.should redirect_to(page_image)
      end
    end

    describe "with invalid params" do
      it "assigns the page_image as @page_image" do
        page_image = PageImage.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        PageImage.any_instance.stub(:save).and_return(false)
        put :update, {:id => page_image.to_param, :page_image => { "page" => "invalid value" }}, valid_session
        assigns(:page_image).should eq(page_image)
      end

      it "re-renders the 'edit' template" do
        page_image = PageImage.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        PageImage.any_instance.stub(:save).and_return(false)
        put :update, {:id => page_image.to_param, :page_image => { "page" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested page_image" do
      page_image = PageImage.create! valid_attributes
      expect {
        delete :destroy, {:id => page_image.to_param}, valid_session
      }.to change(PageImage, :count).by(-1)
    end

    it "redirects to the page_images list" do
      page_image = PageImage.create! valid_attributes
      delete :destroy, {:id => page_image.to_param}, valid_session
      response.should redirect_to(page_images_url)
    end
  end

end
