require 'spec_helper'
require 'rails_helper'

RSpec.describe RevenueBySourcesController, :type => :controller do
  describe "GET index" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template(:index)}
    end

          it "assigns @RevenueBySource" do
          revenue_by_source = RevenueBySource.create
          expect(assigns[:revenue_by_source]).to eq(@revenue_by_source)
          end
  
          it "assigns @revenue_by_source" do
          revenue_by_source = RevenueBySource.all
          expect(revenue_by_source).to be_truthy
          end

  end

  describe "#create" do
    context "when user is admin and logged in" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              revenue_by_source = RevenueBySource.create
              get :index
          end

          it "#save revenue_by_source" do
          revenue_by_source_params = FactoryGirl.attributes_for(:revenue_by_source)
          expect {(assigns[:revenue_by_source]).to eq(RevenueBySource(revenue_by_source_params)) }
          expect { post :create, :revenue_by_source => revenue_by_source_params }.to change(RevenueBySource, :count).by(1) 
          end

          it { expect(response).to have_http_status(200)}
    end

    context "when user is not logged in" do

          before do
              session[:user_id] = nil
              get :new
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
              revenue_by_source = RevenueBySource.create
              get :new
          end

          it {expect(assigns[:revenue_by_source]).to be_a_new(RevenueBySource)}
          it {expect(response).to have_http_status(200)}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("new")}
    end

    context "when user is not logged in" do

          before do
              session[:user_id] = nil
              get :new
          end

          it {expect(response).to redirect_to(login_path)}
          it {expect(flash[:danger]).to eq("Please log in.")}
    end
  end

  describe "#edit" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              @revenue_by_source = create(:revenue_by_source)
              session[:user_id] = @user.id
              get :edit,{:id=>@revenue_by_source.id}
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("edit")}
    end
  end

  describe "#update" do

          before(:each) do
              @revenue_by_source = FactoryGirl.create(:revenue_by_source)
          end

          it "should re-render edit template on failed update" do
          @attr = { :vote_number => "1", :line_item => "100", :july => "30", :august => "1", :september => "100", :october => "30"}
          put :update, :id => @revenue_by_source.id, :revenue_by_source => @attr
          expect(flash[:success]).to eq("Revenue by source was not updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :vote_number => nil, :line_item => "100", :july => "30", :august => "1", :september => "100", :october => "30"}
          put :update, :id => @revenue_by_source.id, :revenue_by_source => @attr
          expect(assigns[:revenue_by_source]).not_to be_new_record
          expect(flash[:success]).not_to eq("Revenue by source was successfully updated.")
          expect(response).to redirect_to revenue_by_sources_url
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

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
              @revenue_by_source = create(:revenue_by_source)
              @user = create(:user)
              session[:user_id] = @user.id
              delete :destroy, :id => @revenue_by_source.id
          end
          
          it {expect(flash[:success]).to eq("Revenue by source was successfully deleted.") }
          it {expect(response).to redirect_to revenue_by_sources_url}
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
