require 'spec_helper'
require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  let(:user) do
    FactoryGirl.create(:user)
  end
  describe "GET new" do
    it "renders the log in template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  describe "#create" do
    before do
      get :new
        #fill_in "email", with: user.email
        #fill_in "password", with: user.password
        #click_button "Log in"
    end
      xit "should successfully create a session" do
        session[:user_id].should be_nil
        post :create
        session[:user_id].should_not be_nil
      end

      xit "should redirect the user to the introduction url" do
        post :create
        response.should redirect_to introduction_url
      end

  end

  describe "#destroy" do
    before do
      post :create
    end
    xit "should clear the session" do
      session[:user_id].should_not be_nil
      delete :destroy
      session[:user_id].should be_nil
    end
    xit "should redirect to the root url" do
      delete :destroy
      response.should redirect_to root_url
    end
  end

end
