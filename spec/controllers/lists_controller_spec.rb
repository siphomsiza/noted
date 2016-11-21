require 'spec_helper'
require 'rails_helper'

RSpec.describe ListsController, :type => :controller do

  describe "GET index" do
    context "when user is admin and logged in" do

          before do
              @list = create(:list)
              session[:list_id] = @list.id
              get :index
          end
          
          it "assigns @list" do
          list = List.create
          expect(assigns[:list]).to be_a_new(List)
          end

          it "assigns @area" do
          areas = Area.create
          expect(assigns(:area)).to eq(@area)
          end

          it "assigns @wards" do
          wards = Ward.all
          expect(wards).to be_truthy
          end

          it "assigns @lists" do
          lists = List.all
          expect(lists).to be_truthy
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
              @list = create(:list)
              session[:user_id] = @user.id
              get :edit,{:id=>@list.id}
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("edit")}
    end
  end

  describe "#create" do
    context "when user is logged in" do

          let(:valid_attributes) { { "name" => "first name", "description" => "text" } }
          let(:valid_session) { {} }

          it "creates a new List" do
          expect {
            post :create, {:list => valid_attributes}, valid_session
                 }.to change(List, :count).by(1)
          end

          it "assigns a newly created list as @list" do
          post :create, {:list => valid_attributes}, valid_session
          expect(assigns(:list)).to be_a(List)
          expect(assigns(:list)).to be_persisted
          end

          it "redirects to the created list" do
          post :create, {:list => valid_attributes}, valid_session
          expect(response).to redirect_to(List)
          end
    end
  end

  describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @list = create(:list)
              session[:list_id] = @list.id
              get :new
          end

          it {expect(assigns[:list]).to be_a_new(List)}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("new")}
    end
  end

  describe "GET #show" do

          it "assigns the requested role to @list" do
          list = FactoryGirl.create(:list)
          get :show, id: list
          expect(assigns(:list)).to be_truthy
          end
  end

  describe "#update" do

          before(:each) do
              @list = FactoryGirl.create(:list)
          end

          it "should re-render edit template on failed update" do
          @attr = { :name => "first name", :description => "text"}
          put :update, :id => @list.id, :list => @attr
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "updated first name", :description => "text"}
          put :update, :id => @list.id, :list => @attr
          expect(assigns[:list]).not_to be_new_record
          expect(flash[:danger]).not_to eq("Location was not saved.")
          expect(response).to redirect_to lists_url
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @list = create(:list)
              delete :destroy,:id => @list.id
              end

              it {expect(flash[:success]).to eq('List was successfully deleted.')}
              it {expect(assigns(:list).destroyed?).to be true}
              it {expect(response.content_type).to eq("text/html") }
              it {expect(response).to redirect_to lists_path}
    end
  end
end
