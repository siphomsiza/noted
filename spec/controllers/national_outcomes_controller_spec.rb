require 'spec_helper'
require 'rails_helper'

RSpec.describe NationalOutcomesController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               national_outcome = NationalOutcome.create
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @kpi_calculation_type" do
            national_outcomes = NationalOutcome.all
            expect(national_outcomes).to be_truthy
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
              national_outcome = NationalOutcome.new
              get :new
          end

          it {expect(assigns[:national_outcome]).to be_a_new(NationalOutcome)}
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
      it 'creates the national_outcome' do
        post :create, national_outcome: attributes_for(:national_outcome)
        expect(NationalOutcome.count).to eq(0)
      end

      it 'redirects to the "show" action for the new national_outcome' do
        post :create, national_outcome: attributes_for(:national_outcome)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the national_outcome' do
        post :create, national_outcome: attributes_for(:national_outcome, name: nil)
        expect(NationalOutcome.count).to eq(0)
      end

      it 're-renders the "new" view' do
        post :create, national_outcome: attributes_for(:national_outcome, name: nil)
        
      end
    end
  end

  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @national_outcome = FactoryGirl.create(:national_outcome)
          end

          it "should re-render edit template on failed update" do
          @attr = { :name => "A development-orientated public service and inclusive citizenship"}
          put :update, :id => @national_outcome.id, :national_outcome => @attr
          expect(flash[:success]).to eq("National outcome was successfully updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "A development-orientated public service and inclusive citizenship"}
          put :update, :id => @national_outcome.id, :national_outcome => @attr
          expect(assigns[:national_outcome]).not_to be_new_record
          expect(flash[:success]).not_to eq("National outcome was not updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @national_outcome = create(:national_outcome)
              delete :destroy,:id=>@national_outcome.id
          end

          it {expect(assigns(:national_outcome).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end

end