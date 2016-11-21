require 'spec_helper'
require 'rails_helper'

RSpec.describe PredeterminedObjectivesController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               predetermined_objective = PredeterminedObjective.create
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @kpi_calculation_type" do
            predetermined_objective = PredeterminedObjective.all
            expect(predetermined_objective).to be_truthy
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
              predetermined_objective = PredeterminedObjective.new
              get :new
          end

          it {expect(assigns[:predetermined_objective]).to be_a_new(PredeterminedObjective)}
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
      it 'creates the predetermined_objective' do
        post :create, predetermined_objective: attributes_for(:predetermined_objective)
        expect(PredeterminedObjective.count).to eq(1)
      end

      it 'redirects to the "show" action for the new predetermined_objective' do
        post :create, predetermined_objective: attributes_for(:predetermined_objective)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the predetermined_objective' do
        post :create, predetermined_objective: attributes_for(:predetermined_objective, name: nil)
        expect(PredeterminedObjective.count).to eq(1)
      end

      it 're-renders the "new" view' do
        post :create, predetermined_objective: attributes_for(:predetermined_objective, name: nil)
        
      end
    end
  end

  describe "#update" do

          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @predetermined_objective = FactoryGirl.create(:predetermined_objective)
          end

          it "should re-render edit template on failed update" do
          @attr = { :name => "(ABC) install"}
          put :update, :id => @predetermined_objective.id, :predetermined_objective => @attr
          expect(flash[:success]).to eq("Predetermined Objective was successfully updated.")
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "Access to library services"}
          put :update, :id => @predetermined_objective.id, :predetermined_objective => @attr
          expect(assigns[:predetermined_objective]).not_to be_new_record
          expect(flash[:success]).not_to eq("Predetermined Objective was not updated.")
          expect(response).to redirect_to :back
          end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @predetermined_objective = create(:predetermined_objective)
              delete :destroy,:id=>@predetermined_objective.id
          end

          it {expect(assigns(:predetermined_objective).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end
end