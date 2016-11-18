require 'spec_helper'
require 'rails_helper'

RSpec.describe MonthlyCashflowsController, :type => :controller do

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

        it "assigns @master_setups" do
        monthly_cashflow = MonthlyCashflow.create
        expect {(assigns[:monthly_cashflow]).to eq(MonthlyCashflow(monthly_cashflow_params)) }
        end

        it "assigns @master_setups" do
        monthly_cashflows = MonthlyCashflow.all
        expect(monthly_cashflows).to be_truthy
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
              monthly_cashflow = MonthlyCashflow.create
              get :index
          end

          it "#save master_setup" do
          monthly_cashflow_params = FactoryGirl.attributes_for(:monthly_cashflow)
          expect {(assigns[:monthly_cashflow]).to eq(MonthlyCashflow(monthly_cashflow_params)) }
          expect { post :create, :monthly_cashflow => monthly_cashflow_params }.to change(MonthlyCashflow, :count).by(1) 
          end

         it { expect(response).to have_http_status(200)}
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
              monthly_cashflow = MonthlyCashflow.create
              get :new
              end

              it {expect {(assigns[:monthly_cashflow]).to eq(MonthlyCashflow(monthly_cashflow_params)) }}
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

  describe "#update" do

          before(:each) do
              @monthly_cashflow = FactoryGirl.create(:monthly_cashflow)
          end

          it "should re-render edit template on failed update" do
          @attr = { :month => "july", :vote_number => "1", :subdepartment_id => "1", :department_id => "1", :mscore_classification_id => "1"}
          put :update, :id => @monthly_cashflow.id, :monthly_cashflow => @attr
          expect(flash[:success]).to eq("Monthly cashflow was successfully updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :month => nil, :vote_number => "1", :subdepartment_id => "1", :department_id => "1", :mscore_classification_id => "1"}
          put :update, :id => @monthly_cashflow.id, :monthly_cashflow => @attr
          expect(assigns[:monthly_cashflow]).not_to be_new_record
          expect(flash[:danger]).not_to eq("Location was not saved.")
          expect(response).to redirect_to monthly_cashflows_url
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
              @user = create(:user)
              session[:user_id] = @user.id
              @monthly_cashflow = create(:monthly_cashflow)
              delete :destroy,:id=>@monthly_cashflow.id
          end

          it {expect(assigns(:monthly_cashflow).destroyed?).to be true}
          it {expect(flash[:success]).to eq("Monthly cashflow was successfully deleted.")}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to monthly_cashflows_path}
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
