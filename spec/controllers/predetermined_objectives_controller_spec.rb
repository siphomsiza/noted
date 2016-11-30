require 'spec_helper'
require 'rails_helper'

RSpec.describe PredeterminedObjectivesController, :type => :controller do

    describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @predetermined_objective = PredeterminedObjective.new
              get :new, :format => 'js'
          end

          it {expect(assigns[:predetermined_objective]).to be_a_new(PredeterminedObjective)}
          it {expect(response.status).to eq(200) }
          it {expect(response.content_type).to eq("text/javascript") }
          it {expect(response).to render_template("new")}
    end
  end

  describe 'POST #create' do
    before(:each) do
    request.env['HTTP_REFERER'] = root_url
  end
    context 'with valid attributes' do
      it 'creates the predetermined_objective' do
        expect{
					post :create, predetermined_objective: attributes_for(:predetermined_objective)
				}.to change(PredeterminedObjective,:count).by(1)
      end

      it 'redirects to the "show" action for the new predetermined_objective' do
        post :create, predetermined_objective: attributes_for(:predetermined_objective)
				expect(flash[:success]).to eq("Predetermined Objective was successfully created.")
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the predetermined_objective' do
				expect{
					post :create, predetermined_objective: attributes_for(:predetermined_objective, name: nil)
				}.to_not change(PredeterminedObjective,:count)
      end

      it 're-renders the "new" view' do
        post :create, predetermined_objective: attributes_for(:predetermined_objective, name: nil)
				expect(flash[:danger]).to eq("Predetermined Objective was not created.")
				expect(response).to redirect_to :back
      end
    end
  end

  describe "#update" do
          before(:each) do
            request.env['HTTP_REFERER'] = root_url
              @predetermined_objective = FactoryGirl.create(:predetermined_objective)
          end

          it "should redirect to index with a notice on successful update" do
          @attr = { :name => "(ABC) install"}
          put :update, :id => @predetermined_objective.id, :predetermined_objective => @attr
          expect(flash[:success]).to eq("Predetermined Objective was successfully updated.")
					expect(response).to redirect_to :back
          end

          it "should redirect to index with a notice on unsuccessful update" do
          @attr = { :name => nil}
          put :update, :id => @predetermined_objective.id, :predetermined_objective => @attr
          expect(assigns[:predetermined_objective]).not_to be_new_record
          expect(flash[:danger]).to eq("Predetermined Objective was not updated.")
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
