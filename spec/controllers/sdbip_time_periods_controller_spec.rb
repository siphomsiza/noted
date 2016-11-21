require 'spec_helper'
require 'rails_helper'

RSpec.describe SdbipTimePeriodsController, :type => :controller do

  describe "GET index" do
    context "when user is admin and logged in" do

          before do
              @sdbip_time_period = create(:sdbip_time_period)
              session[:sdbip_time_period_id] = @sdbip_time_period.id
              get :index
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("index")}
    end

          it "assigns @sdbip_time_period" do
          sdbip_time_period = SdbipTimePeriod.create
          expect(assigns[:sdbip_time_period]).to be_a_new(SdbipTimePeriod)
          end
  end

  describe "#edit" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              @sdbip_time_period = create(:sdbip_time_period)
              session[:user_id] = @user.id
              get :edit,{:id=>@sdbip_time_period.id}
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("edit")}
    end
  end

  describe "POST #import" do

          it "redirects to the home page" do
          allow(SdbipTimePeriod).to receive(:import).with("foo.txt")
          post :import, file: "foo.txt"
          expect(response).to redirect_to sdbip_time_periods_url
          end

          it "adds a flash notice" do
          allow(SdbipTimePeriod).to receive(:import).with("foo.txt")
          post :import, file: "foo.txt"
          expect(flash[:success]).to eq "Time periods imported successfully."
          end

          it "imports the SdbipTimePeriod file" do
          expect(SdbipTimePeriod).to receive(:import).with("foo.txt")
          post :import, file: "foo.txt"
          end
  end

  describe "POST 'create'" do
    context "when valid and when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              sdbip_time_period = SdbipTimePeriod.create
              get :index
          end

          it {expect(assigns[:sdbip_time_period]).not_to be_falsey}
          it {expect(response).to have_http_status(200)}
    end
 
    context "when invalid and when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              sdbip_time_period = SdbipTimePeriod.create
              get :index
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("sdbip_time_periods/index")}
    end
  end

  describe "GET #show" do

          it "assigns the requested sdbip_time_period to @sdbip_time_period" do
          sdbip_time_period = FactoryGirl.create(:sdbip_time_period)
          get :show, id: sdbip_time_period
          expect(assigns(:sdbip_time_period)).to eq(sdbip_time_period)
          end
  
          it "renders the #show view" do
          get :show, id: FactoryGirl.create(:sdbip_time_period)
          expect(response).to render_template :show
          end
  end

  describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @sdbip_time_period = create(:sdbip_time_period)
              session[:sdbip_time_period_id] = @sdbip_time_period.id
              get :new
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("new")}
    end
  end

  describe "#update" do
    context "when user is logged in" do

          before do
          @user = create(:user)
          session[:user_id] = @user.id
          @sdbip_time_period = create(:sdbip_time_period)
          end

          it "" do
          revenue_by_source_params = FactoryGirl.attributes_for(:sdbip_time_period)
          expect {(assigns[:sdbip_time_period]).to eq(SdbipTimePeriod(sdbip_time_period_params)) }
          expect { put :update , :id => @sdbip_time_period.id }
          end

          it {expect(response.status).to eq(200) }
    end
  end

  describe "Get destroy" do
    context "when user is logged in" do

          before do
              @sdbip_time_period = create(:sdbip_time_period)
              @user = create(:user)
              session[:user_id] = @user.id
              delete :destroy, :id => @sdbip_time_period.id
          end

          it "" do
          sdbip_time_period_params = FactoryGirl.attributes_for(:sdbip_time_period)
          expect {(assigns[:sdbip_time_period]).to eq(SdbipTimePeriod(sdbip_time_period_params)) }
          end
          
          it {expect(flash[:success]).to eq("Sdbip Time Period was successfully deleted.") }
          it {expect(response).to redirect_to sdbip_time_periods_url}
    end
  end
end
