require 'spec_helper'
require 'rails_helper'

RSpec.describe CapitalProjectsController, :type => :controller do

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
          it "assigns @capital_project" do
          capital_project = CapitalProject.create
          expect(assigns[:capital_project]).to be_a_new(CapitalProject)
          end

          it "assigns @capital_projects" do
          capital_projects = CapitalProject.all
          get :index
          expect(capital_projects).to be_truthy
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

          it "assigns the requested capital_project to @capital_project" do
          capital_project = CapitalProject.create
          get :show, id: capital_project
          expect(assigns(:capital_project)).to eq(@capital_project)
          end

          it {expect(response.status).to eq(200) }
  end

  describe "#edit" do
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              time_periods = SdbipTimePeriod.create
              session[:user_id] = @user.id
              get :edit, id: time_period
          end

          it {expect(assigns(:time_period)).to eq(time_period) }
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

  describe "#create" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              capital_project = CapitalProject.create
              get :index
          end

          it "#save capital_project" do
          department_params = FactoryGirl.attributes_for(:capital_project)
          expect {(assigns[:capital_project]).to eq(CapitalProject(department_params)) }
          expect { post :create, :capital_project => department_params }.to change(CapitalProject, :count).by(0) 
          end

          it { expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("capital_projects/index")}
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
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              capital_project = CapitalProject.create
              get :new
          end

          it {expect(assigns[:capital_project]).to be_a_new(CapitalProject)}
          it {expect(response.status).to eq(200) }
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

  describe "#update" do

          before(:each) do
              capital_project = CapitalProject.create
          end

          it "should re-render edit template on failed update" do
          @attr = { :project_name => "Technical Services", :project_description => "mm20"}
          put :update, :id => @capital_project.id, :capital_project => @attr
          expect(response.status).to eq(200) 
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :project_name => "water and sanitations", :project_description => "mm20"}
          put :update, :id => @capital_project.id, :capital_project => @attr
          expect(assigns[:capital_project]).not_to be_new_record
          expect(flash[:success]).not_to eq("Capital project was successfully updated.")
          expect(response).to redirect_to capital_projects_url
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

describe "POST #import" do
    it "redirects to the home page" do
      allow(CapitalProject).to receive(:import).with("foo.txt")
      post :import, file: "foo.txt"
      expect(response).to redirect_to capital_projects_url
    end

    it "adds a flash success" do
      allow(CapitalProject).to receive(:import).with("foo.txt")
      post :import, file: "foo.txt"
      expect(flash[:success]).to eq "Capital Projects imported successfully."
      expect(response).to redirect_to capital_projects_url
    end

    it "imports the capital_project file" do
      expect(CapitalProject).to receive(:import).with("foo.txt")
      post :import, file: "foo.txt"
      expect(response).to redirect_to capital_projects_url
    end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @capital_project = CapitalProject.create
              delete :destroy,:id=>@capital_project.id
          end

          it {expect(assigns(:capital_project).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to capital_projects_url}
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
end