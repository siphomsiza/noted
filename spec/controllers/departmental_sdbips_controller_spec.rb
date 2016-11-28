require 'spec_helper'
require 'rails_helper'

RSpec.describe DepartmentalSdbipsController, :type => :controller do

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

          it "assigns @departmental_sdbip" do
          @departmental_sdbip = DepartmentalSdbip.create
          expect {(assigns[:departmental_sdbip]).to eq(DepartmentalSdbip(departmental_sdbip_params)) }
          end

          it "assigns @departments" do
          @departments = Department.create
          expect(assigns(:department)).to eq(@department)
          end

          it "assigns @kpitypes" do
          kpitypes = KpiType.all
          expect(kpitypes).to be_truthy
          end
  end

  describe "#edit" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              @departmental_sdbip = DepartmentalSdbip.create
              session[:user_id] = @user.id
              get :edit,:id=>@departmental_sdbip.id,:format => 'js'
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/javascript") }
          it {expect(response).to render_template("edit")}
    end
  end

  describe "#create" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @departmental_sdbip = DepartmentalSdbip.create
              get :index
          end

          it "#save departmental_sdbip" do
          departmental_sdbip_params = FactoryGirl.attributes_for(:departmental_sdbip)
          expect {(assigns[:departmental_sdbip]).to eq(DepartmentalSdbip(departmental_sdbip_params)) }
          expect { post :create, :departmental_sdbip => departmental_sdbip_params }.to change(DepartmentalSdbip, :count).by(1)
          end

          it { expect(response).to have_http_status(200)}
    end
  end

  describe "#update" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              departmental_sdbip = DepartmentalSdbip.create
          end

          it "" do
          departmental_sdbip_params = FactoryGirl.attributes_for(:departmental_sdbip)
          expect {(assigns[:departmental_sdbip]).to eq(DepartmentalSdbip(departmental_sdbip_params)) }
          expect { put :update , :id => @departmental_sdbip.id }
          end

          it {expect(response.status).to eq(200) }
    end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              departmental_sdbip = DepartmentalSdbip.create
              delete :destroy,:id=>@departmental_sdbip.id
          end

          it "" do
          expect {delete :destroy, @departmental_sdbip }
          end

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
