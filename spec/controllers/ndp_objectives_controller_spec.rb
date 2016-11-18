require 'spec_helper'
require 'rails_helper'

RSpec.describe NdpObjectivesController, :type => :controller do

	describe "GET index" do
      context "when user is admin and logged in" do

            before do
               ndp_objective = NdpObjective.create
              @user = create(:user)
              session[:user_id] = @user.id
              get :index
            end

            it "assigns @kpi_calculation_type" do
            ndp_objectives = NdpObjective.all
            expect(ndp_objectives).to be_truthy
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
              ndp_objective = NdpObjective.new
              get :new
          end

          it {expect(assigns[:ndp_objective]).to be_a_new(NdpObjective)}
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
      it 'creates the ndp_objective' do
        post :create, ndp_objective: attributes_for(:ndp_objective)
        expect(NdpObjective.count).to eq(1)
      end

      it 'redirects to the "show" action for the new ndp_objective' do
        post :create, ndp_objective: attributes_for(:ndp_objective)
        expect(response).to redirect_to :back
      end
    end

    context 'with invalid attributes' do
      it 'does not create the ndp_objective' do
        post :create, ndp_objective: attributes_for(:ndp_objective, name: nil)
        expect(NdpObjective.count).to eq(1)
      end

      it 're-renders the "new" view' do
        post :create, ndp_objective: attributes_for(:ndp_objective, name: nil)
        
      end
    end
  end

 describe "PUT #update" do
    context "with valid params" do

      let(:valid_attributes) {
    { "name" => "Unspecified" }
  }

  let(:invalid_attributes) {
    { "name" => nil }
  }
      let(:new_attributes) {
        { "name" => "Specified" }
      }
      let!(:ndp_objective) { NdpObjective.create(valid_attributes) }

      it "updates the requested ndp_objective" do
        put :update, { id: ndp_objective.id, ndp_objective: new_attributes, format: :json  }
        ndp_objective.reload
        expect(ndp_objective.name).to eq("Specified")
      end

      it "assigns the requested ndp_objective as @ndp_objective" do
        put :update, { id: ndp_objective.id, ndp_objective: valid_attributes, format: :json  }
        expect(assigns(:ndp_objective)).to eq(ndp_objective)
        expect(response).to redirect_to ndp_objectives_url
      end
    end

    context "with invalid params" do
      it "assigns the ndp_objective as @ndp_objective" do
        put :update, { id: ndp_objective.id, ndp_objective: invalid_attributes, format: :json  }
        expect(assigns(:ndp_objective)).to eq(ndp_objective)
      end

      it "returns unprocessable_entity status" do
        put :update, { id: ndp_objective.id, ndp_objective: invalid_attributes, format: :json }
        expect(response.status).to eq(422)
      end
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