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
          @revenue_by_source = RevenueBySource.create
          expect(assigns[:revenue_by_source]).to eq(RevenueBySource.new)
          end
          it "assigns @revenue_by_source" do
          revenue_by_source = RevenueBySource.all
          expect(revenue_by_source).to be_truthy
          end

  end

  describe "#create" do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
    end
          context 'with valid attributes' do
            before do
                @user = create(:user)
                session[:user_id] = @user.id
                @revenue_by_source = RevenueBySource.create
                get :index
            end
            it 'creates the national_outcome' do
              expect do
                post :create, revenue_by_source: attributes_for(:revenue_by_source)
              end.to change(RevenueBySource, :count).by(1)
            end

            it 'redirects to the index action for the new national_outcome' do
              post :create, revenue_by_source: attributes_for(:revenue_by_source)
              expect(flash[:success]).to eq('Revenue by source was successfully created.')
              expect(response).to redirect_to :back
            end
          end

          context 'with invalid attributes' do
            before do
                @user = create(:user)
                session[:user_id] = @user.id
                @revenue_by_source = RevenueBySource.create
                get :index
            end
            it 'does not create the revenue_by_source' do
              expect do
                post :create, revenue_by_source: attributes_for(:revenue_by_source, vote_number: nil)
              end.to_not change(RevenueBySource, :count)
            end

            it 'redirects to the index action for the new national_outcome' do
              post :create, revenue_by_source: attributes_for(:revenue_by_source, vote_number: nil)
              expect(flash[:danger]).to eq('Revenue by source was not created.')
              expect(response).to redirect_to :back
            end
          end
  end
  describe "#edit" do
    context "when user is logged in" do

          before do
              @user = create(:user)
              @revenue_by_source = create(:revenue_by_source)
              session[:user_id] = @user.id
              get :edit, :id=>@revenue_by_source.id, :format => 'js'
          end

          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/javascript") }
          it {expect(response).to render_template("edit")}
    end
  end

  describe "#update" do

          before(:each) do
              request.env['HTTP_REFERER'] = root_url
              @revenue_by_source = FactoryGirl.create(:revenue_by_source)
          end

          it "should redirect to index with a notice on unsuccessful update" do
          @attr = { :vote_number => nil, :line_item => "100", :july => "30", :august => "1", :september => "100", :october => "30"}
          put :update, :id => @revenue_by_source.id, :revenue_by_source => @attr
          expect(flash[:danger]).to eq("Revenue by source was not updated.")
          expect(response).to redirect_to revenue_by_sources_url
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :vote_number => "1", :line_item => "100", :july => "30", :august => "1", :september => "100", :october => "30"}
          put :update, :id => @revenue_by_source.id, :revenue_by_source => @attr
          expect(assigns[:revenue_by_source]).not_to be_new_record
          expect(flash[:success]).to eq("Revenue by source was successfully updated.")
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
