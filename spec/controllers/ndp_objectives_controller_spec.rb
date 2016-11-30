require 'spec_helper'
require 'rails_helper'

RSpec.describe NdpObjectivesController, :type => :controller do

    describe "#new" do
    context "when user is logged in and is admin" do

          before do
              @user = create(:user)
              session[:user_id] = @user.id
              @ndp_objective = NdpObjective.new
              get :new, :format => 'js'
          end

          it {expect(assigns[:ndp_objective]).to be_a_new(NdpObjective)}
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
      it 'creates the ndp_objective' do
        expect{
					post :create, ndp_objective: attributes_for(:ndp_objective)
				}.to change(NdpObjective,:count).by(1)
      end

      it 'redirects to the "show" action for the new ndp_objective' do
        post :create, ndp_objective: attributes_for(:ndp_objective)
				expect(flash[:success]).to eq('NDP objective was successfully created.')
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the ndp_objective' do
				expect{
					post :create, ndp_objective: attributes_for(:ndp_objective, name: nil)
				}.to_not change(NdpObjective,:count)
      end

      it 're-renders the "new" view' do
        post :create, ndp_objective: attributes_for(:ndp_objective, name: nil)
				expect(flash[:danger]).to eq('NDP objective was not created.')
				expect(response).to redirect_to :back
      end
    end
  end

 describe "PUT #update" do
   before(:each) do
     request.env['HTTP_REFERER'] = root_url
     @ndp_objective = FactoryGirl.create(:ndp_objective)
   end
   it 'should redirect to index with a notice on successful update' do
     @attr = { name: 'Waste Management' }
     put :update, id: @ndp_objective.id, ndp_objective: @attr
     expect(flash[:success]).to eq('NDP objective was successfully updated.')
     expect(response).to redirect_to :back
   end

   it 'should redirect to index with a notice on unsuccessful update' do
     @attr = { name: nil }
     put :update, id: @ndp_objective.id, ndp_objective: @attr
     expect(assigns[:ndp_objective]).not_to be_new_record
     expect(flash[:danger]).to eq('NDP objective was not updated.')
     expect(response).to redirect_to :back
   end
  end

  describe "delete#destroy" do
    context "when user is logged in" do

          before do
            request.env['HTTP_REFERER'] = root_url
              @user = create(:user)
              session[:user_id] = @user.id
              @ndp_objective = create(:ndp_objective)
              delete :destroy,:id=>@ndp_objective.id
          end

          it {expect(assigns(:ndp_objective).destroyed?).to be true}
          it {expect(response.content_type).to eq("text/html") }
          it {expect(response).to redirect_to :back}
    end
  end


end
