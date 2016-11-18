require 'spec_helper'
require 'rails_helper'

RSpec.describe JobtitlesController, :type => :controller do

  describe "GET index" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
          end

          it "assigns @jobtitles" do
          jobtitles = Jobtitle.all
          expect(jobtitles).to be_truthy
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("index")}
    end
  end

  describe "#edit" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              jobtitle = Jobtitle.create
              session[:user_id] = @user.id
              get :edit,{:id=>@jobtitle.id}
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("edit")}
    end
  end

  describe "#create" do

    before(:each) do
              @user = create(:user)
              session[:user_id] = @user.id
              jobtitle = Jobtitle.create
              get :index
          end

  context 'json' do
  context 'with valid attributes' do
    it 'creates the jobtitle' do
      post :create, jobtitle: attributes_for(:jobtitle), format: :json
      expect(Jobtitle.count).to eq(2)
    end

    it 'responds with 201' do
      post :create, jobtitle: attributes_for(:jobtitle), format: :json
      expect(response).to have_http_status(201)
    end
  end

  context 'with invalid attributes' do
    it 'does not create the jobtitle' do
      post :create, jobtitle: attributes_for(:jobtitle, title: nil), format: :json
      expect(Jobtitle.count).to eq(1)
    end

    it 'responds with 422' do
      post :create, jobtitle: attributes_for(:jobtitle, title: nil), format: :json
      expect(response).to have_http_status(422)
    end
  end
end
end

  describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              jobtitle = Jobtitle.create
              get :new
          end

          it {expect(assigns[:jobtitle]).to be_a_new(Jobtitle)}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("new")}
    end
  end

   describe "#update" do

          before(:each) do
              @jobtitle = FactoryGirl.create(:jobtitle)
              
          end

          it "should re-render edit template on failed update" do
          @attr = { :title => "KPI Owner"}
          patch :update, :id => @jobtitle.id, :jobtitle => @attr
          expect(flash[:success]).to eq("Jobtitle was successfully updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :title => "New title"}
          patch :update, :id => @jobtitle.id, :jobtitle => @attr
          expect(assigns[:jobtitle]).not_to be_new_record
          expect(flash[:success]).not_to eq("Jobtitle was not updated.")
          expect(response).to redirect_to master_setups_path
          end
  end
  describe "delete#destroy" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @jobtitle = create(:jobtitle)
              delete :destroy,:id=>@jobtitle.id
          end

          it {expect(assigns(:jobtitle).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to master_setups_path}
    end
  end
end
