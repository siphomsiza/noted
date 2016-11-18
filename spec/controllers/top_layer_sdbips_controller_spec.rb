require 'spec_helper'
require 'rails_helper'

RSpec.describe TopLayerSdbipsController, :type => :controller do

 describe "GET index" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
          end

          it "assigns @top_layer_sdbip" do
          top_layer_sdbip = TopLayerSdbip.create
          expect(assigns[:top_layer_sdbip]).to be_a_new(TopLayerSdbip)
          end

          it "assigns @top_layer_sdbips" do
          top_layer_sdbips = TopLayerSdbip.all
          expect(top_layer_sdbips).to be_truthy
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("index")}
    end
  end

  describe "POST #import" do

          it "redirects to the home page" do
          allow(CapitalProject).to receive(:import).with("foo.txt")
          post :import, file: "foo.txt"
          expect(response).to redirect_to top_layer_sdbips_url
          end

          it "adds a flash notice" do
          allow(CapitalProject).to receive(:import).with("foo.txt")
          post :import, file: "foo.txt"
          expect(flash[:success]).to eq "Top Layer SDBIPs imported successfully."
          end

          it "imports the CapitalProject file" do
          expect(CapitalProject).to receive(:import).with("foo.txt")
          post :import, file: "foo.txt"
          end
  end

  describe "#new" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              top_layer_sdbip = TopLayerSdbip.create
              get :new
          end

          it {expect(assigns[:top_layer_sdbip]).to be_a_new(TopLayerSdbip)}
          it {expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("new")}
    end
  end

  describe "#create" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              top_layer_sdbip = TopLayerSdbip.create
              top_layer_sdbip.save
              get :index
          end
          
          it "#save top_layer_sdbip" do
          top_layer_sdbip_params = FactoryGirl.attributes_for(:top_layer_sdbip)
          expect {(assigns[:top_layer_sdbip]).to eq(TopLayerSdbip(jobtitle_params)) }
          expect { post :create, :top_layer_sdbip => top_layer_sdbip_params }.to change(TopLayerSdbip, :count).by(1) 
          end

          it {expect(assigns[:top_layer_sdbip]).to be_a_new(TopLayerSdbip)}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("top_layer_sdbips/index")}
    end
  end
       
  describe "#update" do
    context "when success and when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              top_layer_sdbip = TopLayerSdbip.create
          end

          it {expect(response.status).to eq(200) }
          it { expect(flash[:success]).to be_falsey }
    end
 
    context "when not success and when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              top_layer_sdbip = TopLayerSdbip.create
          end

          it { expect(flash[:danger]).to be_falsey }
    end
  end

  describe "Get destroy" do

    context "when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
          end

          it "" do
          expect {delete :destroy, @top_layer_sdbip }
          end
    end
  end
end
