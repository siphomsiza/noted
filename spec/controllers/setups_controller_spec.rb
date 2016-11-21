require 'spec_helper'
require 'rails_helper'

RSpec.describe SetupsController, :type => :controller do

  describe "GET index" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("index")}
    end

          it "assigns @setup" do
          setup = Setup.create
          expect(assigns[:setup]).to eq(@setup)
          end

          it "assigns @top_layer_sdbips" do
          setups = Setup.all
          expect(setups).to be_truthy
          end

          context "when user is not logged in" do

          before do
              session[:user_id] = nil
              get :index
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#create" do
    context "when user is logged in" do

          before do
              @setup = create(:setup)
              session[:setup_id] = @setup.id
              setup_params = FactoryGirl.attributes_for(:setup)
              get :index
          end

          it "creates setup" do
          setup_params = FactoryGirl.attributes_for(:setup)
          expect { post :create, :setup => setup_params }.to change(Setup, :count).by(1)
          setup = assigns(:setup)
          end

          it {expect(response.content_type).to eq("text/html") }
          it {expect(flash[:danger]).to eq("Setup not saved.")}
          it {expect(response).to redirect_to new_setup_path}
    end

    context "when user is not logged in" do

          before do
              session[:user_id] = nil
              get :index
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#new" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @setup = create(:setup)
              get :new
          end

          it {expect(assigns[:setup]).to be_a_new(Setup)}
          it {expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("new")}
    end

    context "when user is not logged in" do

          before do
              session[:user_id] = nil
              get :index
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "GET #show" do

          it "assigns the requested setup to @setup" do
          setup = FactoryGirl.create(:setup)
          get :show, id: setup
          expect(assigns(:setup)).to eq(@setup)
          end

          context "when user is not logged in" do

          before do
              session[:user_id] = nil
              get :index
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#edit" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              @setup = create(:setup)
              session[:user_id] = @user.id
              get :edit,{:id=>@setup.id}
          end
           
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("edit")}
    end

    context "when user is not logged in" do

          before do
              session[:user_id] = nil
              get :index
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#update" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @setup = create(:setup)
          end

          it "" do
          setup_params = FactoryGirl.attributes_for(:setup)
          expect {(assigns[:setup]).to eq(Setup(setup_params)) }
          expect { put :update , :id => @setup.id }
          end

          it {expect(response.status).to eq(200) }
    end

    context "when user is not logged in" do

          before do
              session[:user_id] = nil
              get :index
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "Get destroy" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @setup = create(:setup)
              get :destroy,:id=>@setup.id
          end

          it {expect(response.content_type).to eq("text/html") }
          it {expect(assigns(:setup).destroyed?).to be true}
          it {expect(response).to redirect_to setups_path}
    end

    context "when user is not logged in" do

          before do
              get :index
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end
end
