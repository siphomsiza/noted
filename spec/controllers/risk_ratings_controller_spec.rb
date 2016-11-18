require 'spec_helper'
require 'rails_helper'

RSpec.describe RiskRatingsController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               risk_rating = RiskRating.create
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @risk_rating" do
            risk_ratings = RiskRating.all
            expect(risk_ratings).to be_truthy
            end

            it {expect(response.status).to eq(200) }
            it {expect(response.content_type).to eq("text/html") }
            it {expect(response).to render_template("index")}
      end
    end

    describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              risk_rating = RiskRating.new
              get :new
          end

          it {expect(assigns[:risk_rating]).to be_a_new(RiskRating)}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to render_template("new")}
    end
  end

  describe 'POST #create' do

    before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end
    context 'with valid attributes' do
      it 'creates the risk_rating' do
        post :create, risk_rating: attributes_for(:risk_rating)
        expect(RiskRating.count).to eq(1)
      end

      it 'redirects to the "show" action for the new risk_rating' do
        post :create, risk_rating: attributes_for(:risk_rating)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the risk_rating' do
        post :create, risk_rating: attributes_for(:risk_rating, name: nil)
        expect(RiskRating.count).to eq(1)
      end

      it 're-renders the "new" view' do
        post :create, risk_rating: attributes_for(:risk_rating, name: nil)
        
      end
    end
  end

  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @risk_rating = FactoryGirl.create(:risk_rating)
          end

          it "should re-render edit template on failed update" do
          @attr = { :name => "High", :code => "H"}
          put :update, :id => @risk_rating.id, :risk_rating => @attr
          expect(flash[:success]).to eq("Risk Rating was successfully updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "Medium", :cote => "H"}
          put :update, :id => @risk_rating.id, :risk_rating => @attr
          expect(assigns[:risk_rating]).not_to be_new_record
          expect(flash[:success]).not_to eq("Risk Rating was not updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @risk_rating = create(:risk_rating)
              delete :destroy,:id=>@risk_rating.id
          end

          it {expect(assigns(:risk_rating).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end


end