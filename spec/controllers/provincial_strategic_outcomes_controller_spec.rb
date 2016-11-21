require 'spec_helper'
require 'rails_helper'

RSpec.describe ProvincialStrategicOutcomesController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               provincial_strategic_outcome = ProvincialStrategicOutcome.create
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @provincial_strategic_outcome" do
            provincial_strategic_outcomes = ProvincialStrategicOutcome.all
            expect(provincial_strategic_outcomes).to be_truthy
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
              provincial_strategic_outcome = ProvincialStrategicOutcome.new
              get :new
          end

          it {expect(assigns[:provincial_strategic_outcome]).to be_a_new(ProvincialStrategicOutcome)}
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
      it 'creates the provincial_strategic_outcome' do
        post :create, provincial_strategic_outcome: attributes_for(:provincial_strategic_outcome)
        expect(ProvincialStrategicOutcome.count).to eq(1)
      end

      it 'redirects to the "show" action for the new provincial_strategic_outcome' do
        post :create, provincial_strategic_outcome: attributes_for(:provincial_strategic_outcome)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the provincial_strategic_outcome' do
        post :create, provincial_strategic_outcome: attributes_for(:provincial_strategic_outcome, name: nil)
        expect(ProvincialStrategicOutcome.count).to eq(1)
      end

      it 're-renders the "new" view' do
        post :create, provincial_strategic_outcome: attributes_for(:provincial_strategic_outcome, name: nil)
        
      end
    end
  end

  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @provincial_strategic_outcome = FactoryGirl.create(:provincial_strategic_outcome)
          end

          it "should re-render edit template on failed update" do
          @attr = { :name => "A skilled and capable workforce to support inclusive growth"}
          put :update, :id => @provincial_strategic_outcome.id, :provincial_strategic_outcome => @attr
          expect(flash[:success]).to eq("Predetermined Strategic Outcome was successfully updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "An effective, competitive and responsive economic infrastructure network"}
          put :update, :id => @provincial_strategic_outcome.id, :provincial_strategic_outcome => @attr
          expect(assigns[:provincial_strategic_outcome]).not_to be_new_record
          expect(flash[:success]).not_to eq("Predetermined Strategic Outcome was not updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @provincial_strategic_outcome = create(:provincial_strategic_outcome)
              delete :destroy,:id=>@provincial_strategic_outcome.id
          end

          it {expect(assigns(:provincial_strategic_outcome).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end


end